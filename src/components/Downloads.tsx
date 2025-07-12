import React from 'react';
import { Download, FileText, Book, FileImage, Presentation } from 'lucide-react';
import { Button } from '@/components/ui/button';
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card';

const Downloads = () => {
  const downloadItems = [
    {
      title: "Full Academic Report",
      description: "Complete comprehensive analysis of the $19 trillion solution",
      file: "Full_Academic_Report.pdf",
      icon: Book,
      featured: true,
      size: "4.4 KB"
    },
    {
      title: "One Page Summary",
      description: "Executive summary for quick overview",
      file: "One_Page_Summary.pdf",
      icon: FileText,
      featured: true,
      size: "2.5 KB"
    },
    {
      title: "Solution Slides",
      description: "Presentation slides explaining the solution",
      file: "19T_Solution_Slides.pptx",
      icon: Presentation,
      featured: false,
      size: "37 KB"
    },
    {
      title: "Solution Mindmap",
      description: "Visual representation of the complete solution",
      file: "Mindmap.png",
      icon: FileImage,
      featured: false,
      size: "83 KB"
    }
  ];

  const topicPdfs = [
    { title: "Topic 1: Introduction & Overview", file: "Topic_1.pdf" },
    { title: "Topic 2: Current Economic State", file: "Topic_2.pdf" },
    { title: "Topic 3: Balance Sheet Analysis", file: "Topic_3.pdf" },
    { title: "Topic 4: Debt Management Strategy", file: "Topic_4.pdf" },
    { title: "Topic 5: Universal Basic Income", file: "Topic_5.pdf" },
    { title: "Topic 6: Implementation Framework", file: "Topic_6.pdf" },
    { title: "Topic 7: Economic Impact", file: "Topic_7.pdf" },
    { title: "Topic 8: Risk Assessment", file: "Topic_8.pdf" },
    { title: "Topic 9: Policy Recommendations", file: "Topic_9.pdf" },
    { title: "Topic 10: Conclusion & Next Steps", file: "Topic_10.pdf" }
  ];

  const handleDownload = (filename: string) => {
    const link = document.createElement('a');
    link.href = `/${filename}`;
    link.download = filename;
    document.body.appendChild(link);
    link.click();
    document.body.removeChild(link);
  };

  return (
    <section className="py-16 bg-gradient-to-br from-blue-50 to-indigo-100">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="text-center mb-16">
          <h2 className="text-3xl font-bold text-gray-900 mb-4">
            Research Documents
          </h2>
          <p className="text-lg text-gray-600 max-w-3xl mx-auto">
            Access the complete research behind the $19 trillion solution. Download detailed analysis, 
            summaries, and supporting materials to understand Australia's economic potential.
          </p>
        </div>

        {/* Featured Downloads */}
        <div className="grid md:grid-cols-2 lg:grid-cols-4 gap-6 mb-12">
          {downloadItems.map((item, index) => {
            const IconComponent = item.icon;
            return (
              <Card key={index} className={`transition-all duration-300 hover:shadow-lg ${item.featured ? 'border-2 border-blue-500 bg-blue-50' : 'hover:shadow-md'}`}>
                <CardHeader className="pb-3">
                  <div className="flex items-center space-x-3">
                    <IconComponent className={`h-6 w-6 ${item.featured ? 'text-blue-600' : 'text-gray-600'}`} />
                    <div className="flex-1">
                      <CardTitle className="text-lg">{item.title}</CardTitle>
                      {item.featured && (
                        <div className="bg-blue-100 text-blue-800 text-xs px-2 py-1 rounded-full inline-block mt-1">
                          Featured
                        </div>
                      )}
                    </div>
                  </div>
                </CardHeader>
                <CardContent className="pt-0">
                  <CardDescription className="mb-4">
                    {item.description}
                  </CardDescription>
                  <div className="flex justify-between items-center">
                    <span className="text-sm text-gray-500">{item.size}</span>
                    <Button 
                      onClick={() => handleDownload(item.file)}
                      className={`${item.featured ? 'bg-blue-600 hover:bg-blue-700' : 'bg-gray-600 hover:bg-gray-700'} text-white`}
                      size="sm"
                    >
                      <Download className="h-4 w-4 mr-2" />
                      Download
                    </Button>
                  </div>
                </CardContent>
              </Card>
            );
          })}
        </div>

        {/* Topic-specific PDFs */}
        <div className="bg-white rounded-lg shadow-md p-8">
          <h3 className="text-2xl font-bold text-gray-900 mb-6 text-center">
            Detailed Topic Analysis
          </h3>
          <p className="text-gray-600 mb-8 text-center">
            Explore each aspect of the solution in detail with our comprehensive topic-specific reports.
          </p>
          <div className="grid md:grid-cols-2 lg:grid-cols-3 gap-4">
            {topicPdfs.map((topic, index) => (
              <div key={index} className="flex items-center justify-between p-4 bg-gray-50 rounded-lg hover:bg-gray-100 transition-colors">
                <div className="flex items-center space-x-3">
                  <FileText className="h-5 w-5 text-gray-600" />
                  <span className="text-sm font-medium text-gray-900">{topic.title}</span>
                </div>
                <Button 
                  onClick={() => handleDownload(topic.file)}
                  variant="outline"
                  size="sm"
                  className="ml-4"
                >
                  <Download className="h-4 w-4" />
                </Button>
              </div>
            ))}
          </div>
        </div>

        {/* Call to Action */}
        <div className="text-center mt-12">
          <div className="bg-blue-600 text-white rounded-lg p-8">
            <h3 className="text-2xl font-bold mb-4">Need More Information?</h3>
            <p className="text-blue-100 mb-6">
              These documents represent extensive research into Australia's economic potential. 
              For questions or collaboration opportunities, reach out to our team.
            </p>
            <Button 
              className="bg-white text-blue-600 hover:bg-blue-50"
              size="lg"
            >
              Contact Us
            </Button>
          </div>
        </div>
      </div>
    </section>
  );
};

export default Downloads;

