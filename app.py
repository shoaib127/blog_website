from enum import unique
from operator import pos
from flask import Flask,request
from flask.helpers import url_for
from flask.templating import render_template
from flask.wrappers import Request
from sqlalchemy.orm import with_expression
from werkzeug.exceptions import RequestEntityTooLarge

import json
import os
import math
from flask_mail import Mail

from flask import session

from flask_sqlalchemy import SQLAlchemy
from werkzeug.utils import redirect, secure_filename
from datetime import datetime
app=Flask(__name__)

with open('config.json','r') as c:
    params=json.load(c)['params']
app.secret_key=params["session_key"]
app.config.update(
    MAIL_SERVER ='smtp.gmail.com',
    MAIL_PORT='465',
    MAIL_USE_SSL=True,
    MAIL_USERNAME=params["gmail_username"],
    MAIL_PASSWORD=params['gmail_password']
)

app.config["UPLOAD_FOLDER"] = params["upload_location"]

mail=Mail(app)
localserver=True
if localserver:
    app.config['SQLALCHEMY_DATABASE_URI'] = params['local_uri']
else:
    app.config['SQLALCHEMY_DATABASE_URI'] = params['prod_uri']

db = SQLAlchemy(app)

class Contact(db.Model):
    '''
    sno,name,phoneno,message,date,email
    '''
    sno=db.Column(db.Integer,primary_key=True)
    Name=db.Column(db.String(80),unique=True,nullable=False)
    Email=db.Column(db.String(20),unique=True,nullable=False)
    Message=db.Column(db.String(100),nullable=False)
    date=db.Column(db.String(12),nullable=False)
    Phoneno=db.Column(db.String(12),nullable=False)

class Posts(db.Model):
    '''
    sno,date,title,content,slug
    '''
    sno=db.Column(db.Integer,primary_key=True)
    title=db.Column(db.String(50),nullable=False)
    date=db.Column(db.String(50),nullable=True)
    content=db.Column(db.String(100),nullable=False)
    slug=db.Column(db.String(100),nullable=False)
    image_file=db.Column(db.String(50),nullable=False)
    tagline=db.Column(db.String(100),nullable=True)

    
@app.route("/")
def home():
    # page= request.args.get('page',1,type=int)
    posts = Posts.query.filter_by().all()
    last = math.ceil(len(posts)/2)
    
    # pagination
    page= request.args.get('page')
    if not str(page).isnumeric():
        page=1
    page=int(page)
    # p = Posts.query.pagi
    posts=posts[(page-1)*2 : (page-1)*2+2]
    #first
    # prev= #
    # next = page+1
    if page==1:
        prev="#"
        next="/?page="+str(page+1)
    elif page==last:
        prev="/?page="+str(page-1)
        next="#"
    else:
        prev="/?page="+str(page-1)
        next="/?page="+str(page+1)

    # middle
    # prev = page - 1
    # next = page+1

    #last
    # prev = page-1
    # next=#

    # social_params=params
    # print(params)
    
    return render_template("index.html",params=params,posts=posts,next=next,prev=prev)

@app.route("/about")
def about():
    return render_template("about.html")

@app.route("/contact",methods=['GET','POST'])
def contact():
    if (request.method=="POST"):
        ''' Add and read to the database'''
        name=request.form.get('name')
        email=request.form.get('email')
        phoneno=request.form.get('phone')
        message=request.form.get("message")

        entry=Contact(Name=name,Email=email,Phoneno=phoneno,Message=message,date=datetime.now())
        db.session.add(entry)
        db.session.commit()

        mail.send_message(
            "new message from blog " + name ,
            sender=email,
            recipients=[params["gmail_username"]],
            body=message + "\n" + phoneno,
            )
    else:

        return render_template("contact.html")
    return redirect("/")

@app.route("/post/<string:post_slug>",methods=['GET'])
def post_route(post_slug):
    post = Posts.query.filter_by(slug=post_slug).first()
    print(post)
    return render_template("post.html",post=post)

@app.route("/admin",methods=['GET','POST'])
def admin():
    if ('user' in session and session['user']==params['adminusername']):
        posts=Posts.query.filter_by().all()

        return render_template("admin.html",posts=posts)


    if request.method=='POST':
        username=request.form.get('username')
        password=request.form.get('password')
        if username==params["adminusername"] and password==params['adminpassword']:
            session['user'] = username
            posts = Posts.query.filter_by().all()
            return render_template("admin.html",posts=posts)
        else:
            return render_template("login.html")

    else:
        return render_template("login.html")

@app.route("/edit/<string:sno>",methods=['GET','POST'])

def edit(sno):
    if 'user' in session and session['user']==params['adminusername']:
        if request.method=='POST':
            edit_title=request.form.get("title")
            edit_tagline=request.form.get("tagline")
            edit_slug=request.form.get("slug")
            edit_content=request.form.get("content")
            edit_image = request.form.get("image")
            date=datetime.now()

            if sno=="0":
                post = Posts(title=edit_title,slug=edit_slug,image_file=edit_image,content=edit_content,tagline=edit_tagline,date=date)
                db.session.add(post)
                db.session.commit()
                # sno="1"
                # return render_template("admin.html")

            else:
                post=Posts.query.filter_by(sno=sno).first()
                post.title = edit_title
                post.tagline=edit_tagline
                post.content=edit_content
                post.image_file=edit_image
                post.slug=edit_slug
                post.date=date
                db.session.commit()
                # posts=Posts.query.filter_by().all()
                return redirect("/admin")
                # return render_template("edit.html",post=posts)
            
        # else:
        posts=Posts.query.filter_by(sno=sno).first()
        return render_template("edit.html",post=posts)

@app.route("/upload",methods=['GET','POST'])
def upload():
    if 'user' in session and session['user']==params["adminusername"]:
        if request.method=='POST':
            f = request.files['file1'] # file1 is the name of the input in admin.html
            f.save(os.path.join(app.config["UPLOAD_FOLDER"],secure_filename(f.filename)))
            return "uploaded successfully"

@app.route("/logout")
def logout():
    session.pop('user')
    return redirect('/admin')

@app.route("/delete/<string:sno>",methods=['GET','POST'])
def delete(sno):
    if 'user' in session and session['user']==params["adminusername"]:
        post=Posts.query.filter_by(sno=sno).first()
        db.session.delete(post)
        db.session.commit()
        return redirect("/admin")

if __name__=="__main__":
    app.run(debug=True)

