from flask import Flask, request, jsonify
from flask_cors import CORS
import mysql.connector

app = Flask(__name__)
CORS(app)

# Database configuration
db_config = {
    'user': 'root',     # Change this to your MySQL username
    'password': 'password',  # Change this to your MySQL password
    'host': '172.17.0.2',
    'database': 'Users',  # Change this to your MySQL database name
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
