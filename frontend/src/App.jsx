import { useState } from 'react';
import SearchForm from './components/SearchForm.jsx';
import SummaryView from './components/SummaryView.jsx';
import { fetchClient } from './utils/api.js';

function App() {
  const [currentView, setCurrentView] = useState('search');
  const [activeClient, setActiveClient] = useState(null);
  const [feedbackMessage, setFeedbackMessage] = useState('');
  const [lastQuery, setLastQuery] = useState(null);
  const [isLoading, setIsLoading] = useState(false);

  const handleSearch = async ({ documentType, documentNumber }) => {
    setLastQuery({ documentType, documentNumber });
    setFeedbackMessage('');
    setIsLoading(true);

    try {
      const { data, errorMessage, status } = await fetchClient({ documentType, documentNumber });

      if (status === 200 && data) {
        setActiveClient(data);
        setCurrentView('summary');
        return;
      }

      setActiveClient(null);
      setCurrentView('search');
      setFeedbackMessage(errorMessage || 'No encontramos informacion con los datos ingresados. Verifica e intentalo nuevamente.');
    } catch (error) {
      setActiveClient(null);
      setCurrentView('search');
      setFeedbackMessage(error.message || 'Ocurrio un error inesperado. Intentalo nuevamente.');
    } finally {
      setIsLoading(false);
    }
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
      isLoading={isLoading}
    />
  );
}

export default App;
