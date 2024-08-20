import os
from flask import Flask, request, jsonify
from flask_cors import CORS
import mysql.connector



app = Flask(__name__)
CORS(app)

db_config = {
    'user': os.getenv('DB_USER', 'root'),
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




@app.route('/api/udnotes/<int:id>', methods=['PUT'])
def update_note(id):
    updated_note = request.json
    title = updated_note.get('title')
    content = updated_note.get('content')

    conn = get_db_connection()
    cursor = conn.cursor()

    cursor.execute("""
        UPDATE notes
        SET title = %s, content = %s
        WHERE id = %s
    """, (title, content, id))

    conn.commit()
    cursor.close()
    conn.close()

    return jsonify({'message': 'Note updated successfully!'}), 200

@app.route('/api/udnotes/<int:id>', methods=['DELETE'])
def delete_note(id):
    conn = get_db_connection()
    cursor = conn.cursor()

    cursor.execute("DELETE FROM notes WHERE id = %s", (id,))

    conn.commit()
    cursor.close()
    conn.close()

    return jsonify({'message': 'Note deleted successfully!'}), 200



if __name__ == '__main__':
     app.run(host='0.0.0.0', port=5001, debug=True)

