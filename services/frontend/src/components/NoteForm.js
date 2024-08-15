// src/components/NoteForm.js
import React, { useState } from 'react';
import api from '../api';

const NoteForm = ({ fetchNotes, note }) => {
  const [content, setContent] = useState(note ? note.content : '');

  const handleSubmit = async (e) => {
    e.preventDefault();
    try {
      if (note) {
        await api.put(`/notes/${note.id}`, { content });
      } else {
        await api.post('/notes', { content });
      }
      fetchNotes();
    } catch (error) {
      console.error('Note form error', error);
    }
  };

  return (
    <form onSubmit={handleSubmit}>
      <textarea value={content} onChange={(e) => setContent(e.target.value)} required />
      <button type="submit">{note ? 'Update Note' : 'Add Note'}</button>
    </form>
  );
};

export default NoteForm;