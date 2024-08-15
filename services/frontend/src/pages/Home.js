// src/pages/Home.js
import React, { useState, useEffect } from 'react';
import api from '../api';
import NoteForm from '../components/NoteForm';
import NoteList from '../components/NoteList';

const Home = () => {
  const [notes, setNotes] = useState([]);
  const [editingNote, setEditingNote] = useState(null);

  const fetchNotes = async () => {
    try {
      const response = await api.get('/notes');
      setNotes(response.data);
    } catch (error) {
      console.error('Fetch notes error', error);
    }
  };

  useEffect(() => {
    fetchNotes();
  }, []);

  return (
    <div>
      <h2>Notes</h2>
      <NoteForm fetchNotes={fetchNotes} note={editingNote} />
      <NoteList notes={notes} fetchNotes={fetchNotes} setEditingNote={setEditingNote} />
    </div>
  );
};

export default Home;