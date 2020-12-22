from flask import Flask
import mysql.connector as db
import json
import os

DATABASE_CREDENTIALS = {
    'host': os.environ['DATABASE_HOST'],
    'user': os.environ['DATABASE_USER'],
    'password': os.environ['DATABASE_PASSWORD'],
    'database': os.environ['DATABASE_NAME']
}

app = Flask(__name__)


def execute(query):
    con = None
    try:
        con = db.connect(**DATABASE_CREDENTIALS)
        cur = con.cursor()
        cur.execute(query)
        return cur.fetchall()
    except db.Error as e:
        print("Error %d: %s" % (e.args[0], e.args[1]))
        return None
    finally:
        if con:
            con.close()


def list_users():
    users = execute("SELECT id, username, email FROM users") or []
    return [{"id": user_id, "username": username, "email": email} for (user_id, username, email) in users]


@app.route("/users")
def users_index():
    return json.dumps(list_users())


if __name__ == "__main__":
    app.run(host='0.0.0.0', port=5000, debug=True)
