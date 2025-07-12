import React from 'react';
import { Helmet } from 'react-helmet';

interface SEOProps {
  title?: string;
  description?: string;
  keywords?: string;
  image?: string;
  url?: string;
  type?: string;
  twitterCard?: string;
}

const SEOHelmet: React.FC<SEOProps> = ({
  title = "The $19 Trillion Solution - Australia's Economic Potential Unlocked",
  description = "Discover how Australia can unlock its $19 trillion balance sheet value to wipe public debt, pre-pay government for 5 years, and fund a Universal Basic Income for every citizen.",
  keywords = "Australia, economy, UBI, Universal Basic Income, public debt, economic policy, $19 trillion, Australian economy, wealth distribution, fiscal policy",
  image = "https://abundantaussie.com/social-share.svg",
  url = "https://abundantaussie.com/",
  type = "website",
  twitterCard = "summary_large_image"
}) => {
  return (
    <Helmet>
      {/* Primary Meta Tags */}
      <title>{title}</title>
      <meta name="title" content={title} />
      <meta name="description" content={description} />
      <meta name="keywords" content={keywords} />
      <meta name="robots" content="index, follow" />
      <meta name="language" content="English" />
      <meta name="revisit-after" content="7 days" />
      
      {/* Canonical URL */}
      <link rel="canonical" href={url} />
      
      {/* Open Graph / Facebook */}
      <meta property="og:type" content={type} />
      <meta property="og:url" content={url} />
      <meta property="og:title" content={title} />
      <meta property="og:description" content={description} />
      <meta property="og:image" content={image} />
      <meta property="og:image:width" content="1200" />
      <meta property="og:image:height" content="630" />
      <meta property="og:image:type" content="image/svg+xml" />
      <meta property="og:site_name" content="Abundant Aussie" />
      <meta property="og:locale" content="en_AU" />
      
      {/* Twitter */}
      <meta property="twitter:card" content={twitterCard} />
      <meta property="twitter:url" content={url} />
      <meta property="twitter:title" content={title} />
      <meta property="twitter:description" content={description} />
      <meta property="twitter:image" content={image} />
      <meta property="twitter:creator" content="@abundantaussie" />
      <meta property="twitter:site" content="@abundantaussie" />
      
      {/* Additional Meta Tags */}
      <meta name="theme-color" content="#1e3a8a" />
      <meta name="msapplication-TileColor" content="#1e3a8a" />
      
      {/* Structured Data */}
      <script type="application/ld+json">
        {JSON.stringify({
          "@context": "https://schema.org",
          "@type": "WebSite",
          "name": "Abundant Aussie",
          "url": url,
          "description": description,
          "potentialAction": {
            "@type": "SearchAction",
            "target": `${url}?q={search_term_string}`,
            "query-input": "required name=search_term_string"
          }
        })}
      </script>
    </Helmet>
  );
};

export default SEOHelmet;

