import React from 'react';

export const DownloadBook: React.FC = () => {
  return (
    <div className="bg-gradient-to-r from-[#0a0a0a] to-[#1a1a1a] p-8 rounded-lg shadow-lg max-w-2xl mx-auto my-8">
      <div className="text-center space-y-4">
        <h2 className="text-3xl font-bold bg-gradient-to-r from-cyan-400 to-fuchsia-400 bg-clip-text text-transparent">
          Download the Complete Book
        </h2>
        
        <p className="text-gray-300">
          Get the comprehensive guide to Australia's $19 trillion economic transformation.
        </p>
        
        <div className="mt-6">
          <a
            href="/economic-reform-proposal.pdf"
            className="inline-flex items-center px-6 py-3 text-lg font-semibold rounded-lg bg-gradient-to-r from-cyan-500 to-fuchsia-500 text-black hover:from-cyan-400 hover:to-fuchsia-400 transition-all duration-200 shadow-lg hover:shadow-cyan-500/25"
            download
          >
            <svg
              className="w-6 h-6 mr-2"
              fill="currentColor"
              viewBox="0 0 20 20"
              xmlns="http://www.w3.org/2000/svg"
            >
              <path
                fillRule="evenodd"
                d="M3 17a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1zm3.293-7.707a1 1 0 011.414 0L9 10.586V3a1 1 0 112 0v7.586l1.293-1.293a1 1 0 111.414 1.414l-3 3a1 1 0 01-1.414 0l-3-3a1 1 0 010-1.414z"
                clipRule="evenodd"
              />
            </svg>
            Download PDF
          </a>
        </div>
        
        <p className="text-sm text-gray-400 mt-4">
          Featuring our signature dark neon theme with cyan/magenta gradients
        </p>
      </div>
    </div>
  );
};

export default DownloadBook;
