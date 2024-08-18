import React, { useState, useEffect } from 'react';
import axios from 'axios';

function App() {
  const [notes, setNotes] = useState([]);
  const [newNote, setNewNote] = useState({ title: '', content: '' });

  useEffect(() => {
    fetchNotes();
  }, []
);

  const fetchNotes = async () => {
    const response = await axios.get(`${process.env.REACT_APP_API_URL}/notes`);
    setNotes(response.data);
  };

  const addNote = async () => {
    if (newNote.title && newNote.content) {
      await axios.post(`${process.env.REACT_APP_API_URL}/notes`, newNote);
      setNewNote({ title: '', content: '' });
      fetchNotes();
    }
  };

  return (
    <div className="App">
      <h1>Notes</h1>
      <ul>
        {notes.map((note) => (
          <li key={note.id}>
            <h3>{note.title}</h3>
            <p>{note.content}</p>
          </li>
        ))}
      </ul>
      <h2>Add a New Note</h2>
      <input
        type="text"
        placeholder="Title"
        value={newNote.title}
        onChange={(e) => setNewNote({ ...newNote, title: e.target.value })}
      />
      <br />
      <textarea
        placeholder="Content"
        value={newNote.content}
        onChange={(e) => setNewNote({ ...newNote, content: e.target.value })}
      />
      <br />
      <button onClick={addNote}>Add Note</button>
    </div>
  );
}

export default App;


//frontend