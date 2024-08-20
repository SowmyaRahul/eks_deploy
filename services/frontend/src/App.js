import axios from 'axios';
import React, { useState, useEffect } from 'react';

const NotesComponent = () => {
  const [notes, setNotes] = useState([]);
  const [newNote, setNewNote] = useState({ title: '', content: '' });
  const [editingNote, setEditingNote] = useState(null);

  useEffect(() => {
    fetchNotes();
  }, []);

  const fetchNotes = async () => {
    const apiBaseUrl = process.env.REACT_APP_API_BASE_URL;
    const response = await axios.get(`${apiBaseUrl}/api/notes`);
    setNotes(response.data);
  };

  const addNote = async () => {
    if (newNote.title && newNote.content) {
      const apiBaseUrl = process.env.REACT_APP_API_BASE_URL;
      await axios.post(`${apiBaseUrl}/api/notes`, newNote);
      setNewNote({ title: '', content: '' });
      fetchNotes();
    }
  };

  const updateNote = async (id) => {
    const apiBaseUrl1 = process.env.REACT_APP_API_BASE_URL;
    await axios.put(`${apiBaseUrl1}/api/udnotes/${id}`, editingNote);
    setEditingNote(null); // Clear the editing state
    fetchNotes();
  };

  const deleteNote = async (id) => {
    const apiBaseUrl1 = process.env.REACT_APP_API_BASE_URL;
    await axios.delete(`${apiBaseUrl1}/api/udnotes/${id}`);
    fetchNotes();
  };

  return (
    <div>
      <h2>Notes</h2>
      <ul>
        {notes.map(note => (
          <li key={note.id}>
            {editingNote && editingNote.id === note.id ? (
              <>
                <input
                  type="text"
                  value={editingNote.title}
                  onChange={(e) => setEditingNote({ ...editingNote, title: e.target.value })}
                />
                <textarea
                  value={editingNote.content}
                  onChange={(e) => setEditingNote({ ...editingNote, content: e.target.value })}
                />
                <button onClick={() => updateNote(note.id)}>Save</button>
                <button onClick={() => setEditingNote(null)}>Cancel</button>
              </>
            ) : (
              <>
                <h3>{note.title}</h3>
                <p>{note.content}</p>
                <button onClick={() => setEditingNote(note)}>Edit</button>
                <button onClick={() => deleteNote(note.id)}>Delete</button>
              </>
            )}
          </li>
        ))}
      </ul>
      <h2>Add a New Note</h2>
      <input
        type="text"
        value={newNote.title}
        onChange={(e) => setNewNote({ ...newNote, title: e.target.value })}
        placeholder="Title"
      />
      <textarea
        value={newNote.content}
        onChange={(e) => setNewNote({ ...newNote, content: e.target.value })}
        placeholder="Content"
      />
      <button onClick={addNote}>Add Note</button>
    </div>
  );
};

export default NotesComponent;
