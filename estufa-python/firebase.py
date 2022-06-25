import datetime
import pyrebase

config = {
  "apiKey": "teste-c476d",
  "authDomain": "teste-c476d.firebaseapp.com",
  "databaseURL": "https://teste-c476d-default-rtdb.firebaseio.com/",
  "storageBucket": "gs://teste-c476d.appspot.com"
}

firebase = pyrebase.initialize_app(config)

db = firebase.database()

dado = '{"temperatura":38, "humidade":40, "data": '+ str(datetime.datetime.now()) + '}'

db.child("medicoes").push(dado)


print(dado)

# db.child("users").child("Morty")
# data = {"name": "Mortimer 'Morty' Smith"}
# db.child("users").push(data)