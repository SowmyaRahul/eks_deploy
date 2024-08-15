// src/components/NoteList.js
import React from 'react';
import api from '../api';

const NoteList = ({ notes, fetchNotes, setEditingNote }) => {
  const handleDelete = async (noteId) => {
    try {
      await api.delete(`/notes/${noteId}`);
      fetchNotes();
    } catch (error) {
      console.error('Delete note error', error);
    }
  };

  return (
    <ul>
      {notes.map(note => (
        <li key={note.id}>
          <p>{note.content}</p>
          <button onClick={() => setEditingNote(note)}>Edit</button>
          <button onClick={() => handleDelete(note.id)}>Delete</button>
        </li>
      ))}
    </ul>
  );
};

export default NoteList;