from flask_dance.contrib.google import make_google_blueprint, google
from flask import Flask, redirect, url_for, render_template
import logging
import os

app = Flask(__name__)

client_id = "918255099801-l8jhvmphhep1v8uq1g914aab2ck533i5.apps.googleusercontent.com"
client_secret = "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"
app.secret_key = "teste123"


os.environ["OAUTHLIB_INSECURE_TRANSPORT"] = "1"
os.environ["OAUTHLIB_RELAX_TOKEN_SCOPE"] = "1"


bluepirnt = make_google_blueprint(
    client_id=client_id,
    client_secret=client_secret,
    reprompt_consent=True,
    scope=["profile","email"]    
)

app.register_blueprint(bluepirnt, url_prefix="/login")

@app.route("/")
def index():
    google_data=None
    user_info_endpoint = "oauth2/v2/userinfo"
    if google.authorized:
        google_data = google.get(user_info_endpoint).json()
        
    render_template("index.html", google_data=google_data, 
                    fetch_url=google.base_url+user_info_endpoint)
    

@app.route("/login")
def login():
    return redirect(url_for("google.login"))

if __name__ == "__main__":
    app.run()