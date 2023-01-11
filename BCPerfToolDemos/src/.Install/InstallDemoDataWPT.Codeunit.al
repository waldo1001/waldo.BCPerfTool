codeunit 62205 "Install Demo Data WPT"
{
    Subtype = Install;

    trigger OnInstallAppPerCompany()
    begin
        FillData();
    end;

    procedure FillData()
    begin
        FillJustSomeCountries();
        EmptyTable();
        SetupNumberSequences();
        InsertBigTables();
    end;

    local procedure InsertBigTables()
    var
        JustSomeTableWPT: Record "Just Some Table WPT";
        JustSomeExtendedTable1WPT: Record "Just Some Extended Table 1 WPT";
        JustSomeExtendedTable2WPT: Record "Just Some Extended Table 2 WPT";
        JustSomeExtendedTable3WPT: Record "Just Some Extended Table 3 WPT";
        JustSomeExtendedTable4WPT: Record "Just Some Extended Table 4 WPT";
        ObsoleteTableWPT: Record "Obsolete Table WPT";
        TableWithObsoleteFieldsWPT: Record "Table With Obsolete Fields WPT";
        JobQueueEntry1: Record "Job Queue Entry";
        JobQueueEntry2: Record "Job Queue Entry";
        JobQueueEntry3: Record "Job Queue Entry";
        JobQueueEntry4: Record "Job Queue Entry";
        JobQueueEntry5: Record "Job Queue Entry";
        JobQueueEntry6: Record "Job Queue Entry";
        JobQueueEntry7: Record "Job Queue Entry";
        RecId: Recordid;
        ScheduleAt: DateTime;
    begin
        ScheduleAt := CreateDateTime(CalcDate('<+1D>', today), Time());

        if JustSomeTableWPT.IsEmpty then
            JobQueueEntry1.ScheduleJobQueueEntryForLater(codeunit::"Install - Big Table WPT", ScheduleAt, '', '');
        if JustSomeExtendedTable1WPT.IsEmpty then
            JobQueueEntry2.ScheduleJobQueueEntryForLater(codeunit::"Install - Big Ext. Table 1 WPT", ScheduleAt, '', '');
        if JustSomeExtendedTable2WPT.IsEmpty then
            JobQueueEntry3.ScheduleJobQueueEntryForLater(codeunit::"Install - Big Ext. Table 2 WPT", ScheduleAt, '', '');
        if JustSomeExtendedTable3WPT.IsEmpty then
            JobQueueEntry4.ScheduleJobQueueEntryForLater(codeunit::"Install - Big Ext. Table 3 WPT", ScheduleAt, '', '');
        if JustSomeExtendedTable4WPT.IsEmpty then
            JobQueueEntry5.ScheduleJobQueueEntryForLater(codeunit::"Install - Big Ext. Table 4 WPT", ScheduleAt, '', '');
        if ObsoleteTableWPT.IsEmpty then
            JobQueueEntry6.ScheduleJobQueueEntryForLater(codeunit::"Install - Obsolete Table WPT", ScheduleAt, '', '');
        if ObsoleteTableWPT.IsEmpty then
            JobQueueEntry6.ScheduleJobQueueEntryForLater(codeunit::"Install - Obsolete Table WPT", ScheduleAt, '', '');
        if TableWithObsoleteFieldsWPT.IsEmpty then
            JobQueueEntry7.ScheduleJobQueueEntryForLater(Codeunit::"Install - Obsolete Fields WPT", ScheduleAt, '', '');
    end;

    local procedure EmptyTable()
    var
        EmptyTableWPT: Record "EmptyTable WPT";
    begin
        if EmptyTableWPT.IsEmpty then exit;

        EmptyTableWPT.DeleteAll();
    end;

    local procedure SetupNumberSequences()
    begin
        if not NumberSequence.Exists('BulkInsertsWithNumberSeq') then NumberSequence.Insert('BulkInsertsWithNumberSeq');
        if not NumberSequence.Exists('JustSomeTableWPT') then NumberSequence.Insert('JustSomeTableWPT');
    end;

    local procedure FillJustSomeCountries()
    var
        JustSomeCountryWPT: Record "Just Some Country WPT";
    begin
        if not JustSomeCountryWPT.IsEmpty then exit;

        InsertCountry('AF', 'Afghanistan');
        InsertCountry('AL', 'Albania');
        InsertCountry('DZ', 'Algeria');
        InsertCountry('AS', 'American Samoa');
        InsertCountry('AD', 'Andorra');
        InsertCountry('AO', 'Angola');
        InsertCountry('AI', 'Anguilla');
        InsertCountry('AQ', 'Antarctica');
        InsertCountry('AG', 'Antigua and Barbuda');
        InsertCountry('AR', 'Argentina');
        InsertCountry('AM', 'Armenia');
        InsertCountry('AW', 'Aruba');
        InsertCountry('AU', 'Australia');
        InsertCountry('AT', 'Austria');
        InsertCountry('AZ', 'Azerbaijan');
        InsertCountry('BS', 'Bahamas (the)');
        InsertCountry('BH', 'Bahrain');
        InsertCountry('BD', 'Bangladesh');
        InsertCountry('BB', 'Barbados');
        InsertCountry('BY', 'Belarus');
        InsertCountry('BE', 'Belgium');
        InsertCountry('BZ', 'Belize');
        InsertCountry('BJ', 'Benin');
        InsertCountry('BM', 'Bermuda');
        InsertCountry('BT', 'Bhutan');
        InsertCountry('BO', 'Bolivia (Plurinational State of)');
        InsertCountry('BQ', 'Bonaire, Sint Eustatius and Saba');
        InsertCountry('BA', 'Bosnia and Herzegovina');
        InsertCountry('BW', 'Botswana');
        InsertCountry('BV', 'Bouvet Island');
        InsertCountry('BR', 'Brazil');
        InsertCountry('IO', 'British Indian Ocean Territory (the)');
        InsertCountry('BN', 'Brunei Darussalam');
        InsertCountry('BG', 'Bulgaria');
        InsertCountry('BF', 'Burkina Faso');
        InsertCountry('BI', 'Burundi');
        InsertCountry('CV', 'Cabo Verde');
        InsertCountry('KH', 'Cambodia');
        InsertCountry('CM', 'Cameroon');
        InsertCountry('CA', 'Canada');
        InsertCountry('KY', 'Cayman Islands (the)');
        InsertCountry('CF', 'Central African Republic (the)');
        InsertCountry('TD', 'Chad');
        InsertCountry('CL', 'Chile');
        InsertCountry('CN', 'China');
        InsertCountry('CX', 'Christmas Island');
        InsertCountry('CC', 'Cocos (Keeling) Islands (the)');
        InsertCountry('CO', 'Colombia');
        InsertCountry('KM', 'Comoros (the)');
        InsertCountry('CD', 'Congo (the Democratic Republic of the)');
        InsertCountry('CG', 'Congo (the)');
        InsertCountry('CK', 'Cook Islands (the)');
        InsertCountry('CR', 'Costa Rica');
        InsertCountry('HR', 'Croatia');
        InsertCountry('CU', 'Cuba');
        InsertCountry('CW', 'Curaçao');
        InsertCountry('CY', 'Cyprus');
        InsertCountry('CZ', 'Czechia');
        InsertCountry('CI', 'Côte d''Ivoire');
        InsertCountry('DK', 'Denmark');
        InsertCountry('DJ', 'Djibouti');
        InsertCountry('DM', 'Dominica');
        InsertCountry('DO', 'Dominican Republic (the)');
        InsertCountry('EC', 'Ecuador');
        InsertCountry('EG', 'Egypt');
        InsertCountry('SV', 'El Salvador');
        InsertCountry('GQ', 'Equatorial Guinea');
        InsertCountry('ER', 'Eritrea');
        InsertCountry('EE', 'Estonia');
        InsertCountry('SZ', 'Eswatini');
        InsertCountry('ET', 'Ethiopia');
        InsertCountry('FK', 'Falkland Islands (the) [Malvinas]');
        InsertCountry('FO', 'Faroe Islands (the)');
        InsertCountry('FJ', 'Fiji');
        InsertCountry('FI', 'Finland');
        InsertCountry('FR', 'France');
        InsertCountry('GF', 'French Guiana');
        InsertCountry('PF', 'French Polynesia');
        InsertCountry('TF', 'French Southern Territories (the)');
        InsertCountry('GA', 'Gabon');
        InsertCountry('GM', 'Gambia (the)');
        InsertCountry('GE', 'Georgia');
        InsertCountry('DE', 'Germany');
        InsertCountry('GH', 'Ghana');
        InsertCountry('GI', 'Gibraltar');
        InsertCountry('GR', 'Greece');
        InsertCountry('GL', 'Greenland');
        InsertCountry('GD', 'Grenada');
        InsertCountry('GP', 'Guadeloupe');
        InsertCountry('GU', 'Guam');
        InsertCountry('GT', 'Guatemala');
        InsertCountry('GG', 'Guernsey');
        InsertCountry('GN', 'Guinea');
        InsertCountry('GW', 'Guinea-Bissau');
        InsertCountry('GY', 'Guyana');
        InsertCountry('HT', 'Haiti');
        InsertCountry('HM', 'Heard Island and McDonald Islands');
        InsertCountry('VA', 'Holy See (the)');
        InsertCountry('HN', 'Honduras');
        InsertCountry('HK', 'Hong Kong');
        InsertCountry('HU', 'Hungary');
        InsertCountry('IS', 'Iceland');
        InsertCountry('IN', 'India');
        InsertCountry('ID', 'Indonesia');
        InsertCountry('IR', 'Iran (Islamic Republic of)');
        InsertCountry('IQ', 'Iraq');
        InsertCountry('IE', 'Ireland');
        InsertCountry('IM', 'Isle of Man');
        InsertCountry('IL', 'Israel');
        InsertCountry('IT', 'Italy');
        InsertCountry('JM', 'Jamaica');
        InsertCountry('JP', 'Japan');
        InsertCountry('JE', 'Jersey');
        InsertCountry('JO', 'Jordan');
        InsertCountry('KZ', 'Kazakhstan');
        InsertCountry('KE', 'Kenya');
        InsertCountry('KI', 'Kiribati');
        InsertCountry('KP', 'Korea (the Democratic People''s Republic of)');
        InsertCountry('KR', 'Korea (the Republic of)');
        InsertCountry('KW', 'Kuwait');
        InsertCountry('KG', 'Kyrgyzstan');
        InsertCountry('LA', 'Lao People''s Democratic Republic (the)');
        InsertCountry('LV', 'Latvia');
        InsertCountry('LB', 'Lebanon');
        InsertCountry('LS', 'Lesotho');
        InsertCountry('LR', 'Liberia');
        InsertCountry('LY', 'Libya');
        InsertCountry('LI', 'Liechtenstein');
        InsertCountry('LT', 'Lithuania');
        InsertCountry('LU', 'Luxembourg');
        InsertCountry('MO', 'Macao');
        InsertCountry('MG', 'Madagascar');
        InsertCountry('MW', 'Malawi');
        InsertCountry('MY', 'Malaysia');
        InsertCountry('MV', 'Maldives');
        InsertCountry('ML', 'Mali');
        InsertCountry('MT', 'Malta');
        InsertCountry('MH', 'Marshall Islands (the)');
        InsertCountry('MQ', 'Martinique');
        InsertCountry('MR', 'Mauritania');
        InsertCountry('MU', 'Mauritius');
        // InsertCountry('YT', 'Mayotte');
        // InsertCountry('MX', 'Mexico');
        // InsertCountry('FM', 'Micronesia (Federated States of)');
        // InsertCountry('MD', 'Moldova (the Republic of)');
        // InsertCountry('MC', 'Monaco');
        // InsertCountry('MN', 'Mongolia');
        // InsertCountry('ME', 'Montenegro');
        // InsertCountry('MS', 'Montserrat');
        // InsertCountry('MA', 'Morocco');
        // InsertCountry('MZ', 'Mozambique');
        // InsertCountry('MM', 'Myanmar');
        // InsertCountry('NA', 'Namibia');
        // InsertCountry('NR', 'Nauru');
        // InsertCountry('NP', 'Nepal');
        // InsertCountry('NL', 'Netherlands (the)');
        // InsertCountry('NC', 'New Caledonia');
        // InsertCountry('NZ', 'New Zealand');
        // InsertCountry('NI', 'Nicaragua');
        // InsertCountry('NE', 'Niger (the)');
        // InsertCountry('NG', 'Nigeria');
        // InsertCountry('NU', 'Niue');
        // InsertCountry('NF', 'Norfolk Island');
        // InsertCountry('MP', 'Northern Mariana Islands (the)');
        // InsertCountry('NO', 'Norway');
        // InsertCountry('OM', 'Oman');
        // InsertCountry('PK', 'Pakistan');
        // InsertCountry('PW', 'Palau');
        // InsertCountry('PS', 'Palestine, State of');
        // InsertCountry('PA', 'Panama');
        // InsertCountry('PG', 'Papua New Guinea');
        // InsertCountry('PY', 'Paraguay');
        // InsertCountry('PE', 'Peru');
        // InsertCountry('PH', 'Philippines (the)');
        // InsertCountry('PN', 'Pitcairn');
        // InsertCountry('PL', 'Poland');
        // InsertCountry('PT', 'Portugal');
        // InsertCountry('PR', 'Puerto Rico');
        // InsertCountry('QA', 'Qatar');
        // InsertCountry('MK', 'Republic of North Macedonia');
        // InsertCountry('RO', 'Romania');
        // InsertCountry('RU', 'Russian Federation (the)');
        // InsertCountry('RW', 'Rwanda');
        // InsertCountry('RE', 'Réunion');
        // InsertCountry('BL', 'Saint Barthélemy');
        // InsertCountry('SH', 'Saint Helena, Ascension and Tristan da Cunha');
        // InsertCountry('KN', 'Saint Kitts and Nevis');
        // InsertCountry('LC', 'Saint Lucia');
        // InsertCountry('MF', 'Saint Martin (French part)');
        // InsertCountry('PM', 'Saint Pierre and Miquelon');
        // InsertCountry('VC', 'Saint Vincent and the Grenadines');
        // InsertCountry('WS', 'Samoa');
        // InsertCountry('SM', 'San Marino');
        // InsertCountry('ST', 'Sao Tome and Principe');
        // InsertCountry('SA', 'Saudi Arabia');
        // InsertCountry('SN', 'Senegal');
        // InsertCountry('RS', 'Serbia');
        // InsertCountry('SC', 'Seychelles');
        // InsertCountry('SL', 'Sierra Leone');
        // InsertCountry('SG', 'Singapore');
        // InsertCountry('SX', 'Sint Maarten (Dutch part)');
        // InsertCountry('SK', 'Slovakia');
        // InsertCountry('SI', 'Slovenia');
        // InsertCountry('SB', 'Solomon Islands');
        // InsertCountry('SO', 'Somalia');
        // InsertCountry('ZA', 'South Africa');
        // InsertCountry('GS', 'South Georgia and the South Sandwich Islands');
        // InsertCountry('SS', 'South Sudan');
        // InsertCountry('ES', 'Spain');
        // InsertCountry('LK', 'Sri Lanka');
        // InsertCountry('SD', 'Sudan (the)');
        // InsertCountry('SR', 'Suriname');
        // InsertCountry('SJ', 'Svalbard and Jan Mayen');
        // InsertCountry('SE', 'Sweden');
        // InsertCountry('CH', 'Switzerland');
        // InsertCountry('SY', 'Syrian Arab Republic');
        // InsertCountry('TW', 'Taiwan (Province of China)');
        // InsertCountry('TJ', 'Tajikistan');
        // InsertCountry('TZ', 'Tanzania, United Republic of');
        // InsertCountry('TH', 'Thailand');
        // InsertCountry('TL', 'Timor-Leste');
        // InsertCountry('TG', 'Togo');
        // InsertCountry('TK', 'Tokelau');
        // InsertCountry('TO', 'Tonga');
        // InsertCountry('TT', 'Trinidad and Tobago');
        // InsertCountry('TN', 'Tunisia');
        // InsertCountry('TR', 'Turkey');
        // InsertCountry('TM', 'Turkmenistan');
        // InsertCountry('TC', 'Turks and Caicos Islands (the)');
        // InsertCountry('TV', 'Tuvalu');
        // InsertCountry('UG', 'Uganda');
        // InsertCountry('UA', 'Ukraine');
        // InsertCountry('AE', 'United Arab Emirates (the)');
        // InsertCountry('GB', 'United Kingdom of Great Britain and Northern Ireland (the)');
        // InsertCountry('UM', 'United States Minor Outlying Islands (the)');
        // InsertCountry('US', 'United States of America (the)');
        // InsertCountry('UY', 'Uruguay');
        // InsertCountry('UZ', 'Uzbekistan');
        // InsertCountry('VU', 'Vanuatu');
        // InsertCountry('VE', 'Venezuela (Bolivarian Republic of)');
        // InsertCountry('VN', 'Viet Nam');
        // InsertCountry('VG', 'Virgin Islands (British)');
        // InsertCountry('VI', 'Virgin Islands (U.S.)');
        // InsertCountry('WF', 'Wallis and Futuna');
        // InsertCountry('EH', 'Western Sahara');
        // InsertCountry('YE', 'Yemen');
        // InsertCountry('ZM', 'Zambia');
        // InsertCountry('ZW', 'Zimbabwe');
        // InsertCountry('AX', 'Åland Islands');
    end;

    local procedure InsertCountry(Code: Code[10]; Name: Text)
    var
        JustSomeCountry: Record "Just Some Country WPT";
    begin
        JustSomeCountry.Code := Code;
        JustSomeCountry.Name := CopyStr(name, 1, 100);
        if not JustSomeCountry.Insert() then
            JustSomeCountry.Modify();
    end;

    procedure RandomText(Length: Integer): Text[2048]
    var
        GuidTxt: Text;
    begin
        while StrLen(GuidTxt) < Length do
            GuidTxt += LowerCase(DelChr(Format(CreateGuid()), '=', '{}-'));
        exit(CopyStr(GuidTxt, 1, 2048));
    end;


}