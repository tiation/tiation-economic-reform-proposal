
import React from 'react';
import Hero from '@/components/Hero';
import Overview from '@/components/Overview';
import Mechanism from '@/components/Mechanism';
import Benefits from '@/components/Benefits';
import Downloads from '@/components/Downloads';
import FAQ from '@/components/FAQ';
import CallToAction from '@/components/CallToAction';
import Footer from '@/components/Footer';
import FloatingDownloadButton from '@/components/FloatingDownloadButton';
import SEOHelmet from '@/components/SEOHelmet';

const Index = () => {
  return (
    <div className="min-h-screen">
      <Hero />
      <Overview />
      <Mechanism />
      <Benefits />
      <Downloads />
      <FAQ />
      <CallToAction />
      <Footer />
      <FloatingDownloadButton />
    </div>
  );
};

export default Index;
