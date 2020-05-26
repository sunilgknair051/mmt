FactoryBot.define do
  factory :empty_tool_draft, class: ToolDraft do
    provider_id { 'MMT_2' }
    draft_type { 'ToolDraft' }

    draft { {} }

    short_name { nil }
    entry_title { nil }
  end

  # factory :invalid_tool_draft, class: ToolDraft do
  # end

  factory :full_tool_draft, class: ToolDraft do
    transient do
      draft_short_name { nil }
      draft_entry_title { nil }
    end

    native_id { 'full_tool_draft_native_id' }
    provider_id { 'MMT_2' }
    draft_type { 'ToolDraft' }

    draft do
      {
        'Name': draft_short_name || "#{Faker::Games::Zelda.item}_#{Faker::Number.number(digits: 8)}",
        'LongName': draft_entry_title || "#{Faker::Movies::HarryPotter.quote}_#{Faker::Number.number(digits: 8)}",
        'Version': '1.0',
        'VersionDescription': 'Description of the version of the tool.',
        'Type': 'Downloadable Tool',
        'LastUpdatedDate': '2020-05-01T00:00:00Z',
        'Description': 'Description of the factory made tool.',
        'DOI': 'https://doi.org/10.1234/SOMEDAAC/5678',
        'URL': {
          'URLContentType': 'DistributionURL',
          'Type': 'DOWNLOAD SOFTWARE',
          'Description': 'Access the WRS-2 Path/Row to Latitude/Longitude Converter.',
          'URLValue': 'http://www.scp.byu.edu/software/slice_response/Xshape_temp.html'
        },
        'RelatedURLs': [
          {
            'Description': 'Test related url',
            'URLContentType': 'VisualizationURL',
            'Type': 'GET RELATED VISUALIZATION',
            'Subtype': 'MAP',
            'URL': 'nasa.gov'
          },
          {
            'Description': 'Test another related url',
            'URLContentType': 'PublicationURL',
            'Type': 'VIEW RELATED INFORMATION',
            'Subtype': 'ALGORITHM DOCUMENTATION',
            'URL': 'algorithms.org'
          }
        ],
        'SupportedInputFormats': ['GEOTIFFFLOAT32', 'ICARTT'],
        'SupportedOutputFormats': ['KML', 'NETCDF-4'],
        'SupportedOperatingSystems': [
          {
            'OperatingSystemName': 'Puppy Linux',
            'OperatingSystemVersion': '8.8'
          },
          {
            'OperatingSystemName': 'Tails',
            'OperatingSystemVersion': '9.5'
          }
        ],
        'SupportedBrowsers': [
          {
            'BrowserName': '3B',
            'BrowserVersion': '3.0'
          },
          {
            'BrowserName': 'Retawq',
            'BrowserVersion': '1.1'
          }
        ],
        'SupportedSoftwareLanguages': [
          {
            'SoftwareLanguageName': 'LOLCODE',
            'SoftwareLanguageVersion': 'LOL'
          },
          {
            'SoftwareLanguageName': 'Chicken',
            'SoftwareLanguageVersion': 'Chicken Chicken Chicken Chicken'
          }
        ],
        'ToolKeywords': [
          {
            'ToolCategory': 'EARTH SCIENCE SERVICES',
            'ToolTopic': 'DATA MANAGEMENT/DATA HANDLING',
            'ToolTerm': 'DATA INTEROPERABILITY',
            'ToolSpecificTerm': 'DATA REFORMATTING'
          }
        ],
        'AncillaryKeywords': ['Ancillary keyword 1', 'Ancillary keyword 2'],
        'Organizations': [
          {
            'Roles': ['SERVICE PROVIDER', 'DEVELOPER'],
            'ShortName': 'UCAR/NCAR/EOL/CEOPDM',
            'LongName': 'CEOP Data Management, Earth Observing Laboratory, National Center for Atmospheric Research, University Corporation for Atmospheric Research',
            'URLValue': 'http://www.eol.ucar.edu/projects/ceop/dm/'
          },
          {
            'Roles': ['PUBLISHER'],
            'ShortName': 'AARHUS-HYDRO',
            'LongName': 'Hydrogeophysics Group, Aarhus University '
          }
        ],
        'ContactGroups': [
          {
            'Roles': ['SERVICE PROVIDER', 'PUBLISHER'],
            'GroupName': 'Group 1',
            'ContactInformation': {
              'ServiceHours': '9-6, M-F',
              'ContactInstruction': 'Email only',
              'ContactMechanisms': [
                {
                  'Type': 'Email',
                  'Value': 'example@example.com'
                }, {
                  'Type': 'Email',
                  'Value': 'example2@example.com'
                }
              ],
              'Addresses': [
                {
                  'StreetAddresses': ['300 E Street Southwest', 'Room 203', 'Address line 3'],
                  'City': 'Washington',
                  'StateProvince': 'DC',
                  'PostalCode': '20546',
                  'Country': 'United States'
                },
                {
                  'StreetAddresses': ['8800 Greenbelt Road'],
                  'City': 'Greenbelt',
                  'StateProvince': 'MD',
                  'PostalCode': '20771',
                  'Country': 'United States'
                }
              ]
            }
          },
          {
            'Roles': ['SERVICE PROVIDER'],
            'GroupName': 'Group 2'
          }
        ],
        'ContactPersons': [
          {
            'Roles': ['DEVELOPER'],
            'ContactInformation': {
              'ContactMechanisms': [
                {
                  'Type': 'Email',
                  'Value': 'example@example.com'
                }, {
                  'Type': 'Fax',
                  'Value': '800-555-1212'
                }
              ],
              'Addresses': [
                {
                  'StreetAddresses': ['47914 252nd Street'],
                  'City': 'Sioux Falls',
                  'StateProvince': 'SD',
                  'Country': 'USA',
                  'PostalCode': '57198-0001'
                }
              ]
            },
            'FirstName': 'Service Provider Personnel First Name',
            'MiddleName': 'Service Provider Personnel Middle Name',
            'LastName': 'Service Provider Personnel Last Name'
          },
          {
            'Roles': ['DEVELOPER'],
            'LastName': 'Last 2'
          }
        ],
        'MetadataSpecification': {
          'URL': 'https://cdn.earthdata.nasa.gov/umm/tool/v1.0',
          'Name': 'UMM-T',
          'Version': '1.0'
        }
      }
    end
  end
end
