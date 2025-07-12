import React, { useState, useEffect } from 'react';
import { Download } from 'lucide-react';
import { Button } from '@/components/ui/button';

const FloatingDownloadButton = () => {
  const [isVisible, setIsVisible] = useState(false);

  useEffect(() => {
    const toggleVisibility = () => {
      // Show button after scrolling past hero section
      if (window.pageYOffset > 400) {
        setIsVisible(true);
      } else {
        setIsVisible(false);
      }
    };

    window.addEventListener('scroll', toggleVisibility);
    return () => window.removeEventListener('scroll', toggleVisibility);
  }, []);

  const scrollToDownloads = () => {
    document.querySelector('[data-downloads-section]')?.scrollIntoView({ 
      behavior: 'smooth'
    });
  };

  if (!isVisible) {
    return null;
  }

  return (
    <Button
      onClick={scrollToDownloads}
      className="fixed bottom-6 right-6 z-50 bg-blue-600 hover:bg-blue-700 text-white shadow-lg rounded-full p-3 transition-all duration-300 hover:scale-110"
      size="lg"
      aria-label="Jump to Downloads"
    >
      <Download className="w-6 h-6" />
    </Button>
  );
};

export default FloatingDownloadButton;

