import os
from flask import Flask, request, jsonify
from flask_cors import CORS
import mysql.connector



app = Flask(__name__)
CORS(app)

db_config = {
    'user': os.getenv('DB_USER', 'user'),
    'password': os.getenv('DB_PASSWORD', 'password'),
    'host': os.getenv('DB_HOST', '172.17.0.2'),
    'database': os.getenv('DB_NAME', 'Users')
}

# Connect to the MySQL database
def get_db_connection():
    conn = mysql.connector.connect(**db_config)
    return conn

@app.route('/')
def hello():
    return "Hello, World!"


@app.route('/api/notes', methods=['GET'])
def list_notes():
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT * FROM notes")
    notes = cursor.fetchall()
    cursor.close()
    conn.close()
    return jsonify(notes)

@app.route('/api/notes', methods=['POST'])
def add_note():
    new_note = request.json
    title = new_note['title']
    content = new_note['content']
    
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute("INSERT INTO notes (title, content) VALUES (%s, %s)", (title, content))
    conn.commit()
    cursor.close()
    conn.close()
    return jsonify({'message': 'Note added successfully!'}), 201


if __name__ == '__main__':
     app.run(host='0.0.0.0', port=5000, debug=True)

