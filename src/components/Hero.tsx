
import React from 'react';
import { Button } from '@/components/ui/button';
import { ArrowDown, Download } from 'lucide-react';

const Hero = () => {
  const scrollToOverview = () => {
    document.getElementById('overview')?.scrollIntoView({ behavior: 'smooth' });
  };

  const scrollToDownloads = () => {
    document.querySelector('[data-downloads-section]')?.scrollIntoView({ behavior: 'smooth' });
  };

  const downloadSummary = () => {
    const link = document.createElement('a');
    link.href = '/One_Page_Summary.pdf';
    link.download = 'One_Page_Summary.pdf';
    document.body.appendChild(link);
    link.click();
    document.body.removeChild(link);
  };

  return (
    <div className="relative min-h-screen bg-gradient-to-br from-blue-900 via-blue-800 to-blue-950 flex items-center justify-center text-white overflow-hidden">
      <div className="absolute inset-0 opacity-10">
        <div className="absolute top-20 left-20 w-64 h-64 rounded-full bg-yellow-300 blur-3xl"></div>
        <div className="absolute bottom-20 right-20 w-80 h-80 rounded-full bg-blue-400 blur-3xl"></div>
      </div>
      <div className="container mx-auto px-4 relative z-10">
        <div className="max-w-4xl mx-auto text-center">
          <h1 className="text-4xl md:text-6xl lg:text-7xl font-bold mb-6 tracking-tighter">
            The <span className="text-yellow-400">$19 Trillion</span> Solution
          </h1>
          <div className="mb-4">
            <p className="text-2xl md:text-3xl font-bold text-yellow-400 mb-2">
              "What if we shared what we have? Woah. We're rich!!!!"
            </p>
          </div>
          <p className="text-xl md:text-2xl mb-6 max-w-3xl mx-auto text-blue-100">
            Australia's balance sheet reveals we're worth $19 trillion. That's <span className="text-yellow-400 font-bold">$104,000 for every Australian</span>. 
            Unlock just one-third and we can eliminate poverty, abolish public debt, and provide $800 weekly UBI for everyone.
          </p>
          <div className="bg-blue-800/30 backdrop-blur rounded-lg p-6 mb-8 max-w-2xl mx-auto">
            <div className="grid grid-cols-1 md:grid-cols-3 gap-4 text-center">
              <div>
                <div className="text-2xl font-bold text-yellow-400">$800</div>
                <div className="text-sm text-blue-200">Weekly per person</div>
              </div>
              <div>
                <div className="text-2xl font-bold text-yellow-400">$104K</div>
                <div className="text-sm text-blue-200">Your asset share</div>
              </div>
              <div>
                <div className="text-2xl font-bold text-yellow-400">5+ Years</div>
                <div className="text-sm text-blue-200">Pre-funded govt</div>
              </div>
            </div>
          </div>
          <div className="flex flex-col sm:flex-row gap-4 justify-center">
            <Button onClick={scrollToOverview} className="bg-yellow-500 hover:bg-yellow-400 text-blue-900 font-bold px-8 py-6 text-lg rounded-lg">
              Learn More
            </Button>
            <Button onClick={downloadSummary} variant="outline" className="text-white border-white hover:bg-white/10 px-8 py-6 text-lg rounded-lg">
              <Download className="w-5 h-5 mr-2" />
              Download Summary
            </Button>
          </div>
        </div>
      </div>
      <button 
        onClick={scrollToOverview} 
        className="absolute bottom-8 left-1/2 transform -translate-x-1/2 text-white animate-bounce"
        aria-label="Scroll down"
      >
        <ArrowDown className="w-10 h-10" />
      </button>
    </div>
  );
};

export default Hero;
