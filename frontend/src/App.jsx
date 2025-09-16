import { useState } from 'react';
import SearchForm from './components/SearchForm.jsx';
import SummaryView from './components/SummaryView.jsx';
import clientsData from './data/clients.json';

function App() {
  const [currentView, setCurrentView] = useState('search');
  const [activeClient, setActiveClient] = useState(null);
  const [feedbackMessage, setFeedbackMessage] = useState('');
  const [lastQuery, setLastQuery] = useState(null);

  const handleSearch = ({ documentType, documentNumber }) => {
    setLastQuery({ documentType, documentNumber });

    const match = clientsData.find(
      (client) => client.documentType === documentType && client.documentNumber === documentNumber,
    );

    if (match) {
      setActiveClient(match);
      setCurrentView('summary');
      setFeedbackMessage('');
      return;
    }

    setActiveClient(null);
    setCurrentView('search');
    setFeedbackMessage('No encontramos informacion con los datos ingresados. Verifica e intentalo nuevamente.');
  };

  const handleBack = () => {
    setActiveClient(null);
    setCurrentView('search');
    setFeedbackMessage('');
  };

  if (currentView === 'summary' && activeClient) {
    return <SummaryView client={activeClient} onBack={handleBack} />;
  }

  return (
    <SearchForm
      onSearch={handleSearch}
      feedbackMessage={feedbackMessage}
      initialQuery={lastQuery}
    />
  );
}

export default App;
