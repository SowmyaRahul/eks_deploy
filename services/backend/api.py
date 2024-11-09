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

# @app.route('/api/notes/<int:id>', methods=['PUT'])
# def update_note(id):
#     updated_note = request.json
#     title = updated_note.get('title')
#     content = updated_note.get('content')

#     conn = get_db_connection()
#     cursor = conn.cursor()

#     cursor.execute("""
#         UPDATE notes
#         SET title = %s, content = %s
#         WHERE id = %s
#     """, (title, content, id))

#     conn.commit()
#     cursor.close()
#     conn.close()

#     return jsonify({'message': 'Note updated successfully!'}), 200

# @app.route('/api/notes/<int:id>', methods=['DELETE'])
# def delete_note(id):
#     conn = get_db_connection()
#     cursor = conn.cursor()

#     cursor.execute("DELETE FROM notes WHERE id = %s", (id,))

#     conn.commit()
#     cursor.close()
#     conn.close()

#     return jsonify({'message': 'Note deleted successfully!'}), 200

@app.route('/api/notes/rahul2', methods=['GET'])
def rahul():
    return jsonify({'message': 'Rahul experienced YOGA successfully!'}), 200

@app.route('/api/notes/anjuuu2', methods=['GET'])
def anjuuu():
    return jsonify({'message': 'anjuuu experienced YOGA successfully!'}), 200

@app.route('/api/notes/guru2', methods=['GET'])
def guru():
    return jsonify({'message': 'yoga is shambhooo!! GURU is doorway and light'}), 200

@app.route('/api/notes/yoga2', methods=['GET'])
def yoga():
    return jsonify({'message': 'YOGA successfully!'}), 200

@app.route('/api/notes/guru', methods=['GET'])
def guruu():
    return jsonify({'message': 'yoga is shambhooo!! GURU is doorway'}), 200

@app.route('/api/notes/devi', methods=['GET'])
def Shakthi():
    return jsonify({'message': 'Shakthi'}), 200


@app.route('/api/notes/shambhoo', methods=['GET'])
def rahul():
    return jsonify({'message': 'yoga is shambhooo!! reached ultimate state of experience'}), 200

@app.route('/api/notes/shambhoo', methods=['GET'])
def shivashakthi():
    return jsonify({'message': 'yoga is shivashakthi!! reached ultimate state of experience'}), 200


if __name__ == '__main__':
     app.run(host='0.0.0.0', port=5000, debug=True)

