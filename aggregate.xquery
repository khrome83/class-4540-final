(:
    Name: Zane C. Milakovic
    Date: 11/08/2015
    File: toilet.1.xquery
:)

declare default element namespace "http://toiletmap.gov.au/";
declare copy-namespaces no-preserve, no-inherit;

<Toilets
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:xsd="http://www.w3.org/2001/XMLSchema-datatypes"
    xmlns:xs="http://www.w3.org/2001/XMLSchema">
    {
        let $doc := doc("ToiletmapExport.xml")//ToiletDetails
        let $allToilets := $doc[Town = "Darkan"]
        
        for $x in $allToilets
            let $lat := string($x/@Latitude)
            let $long := string($x/@Longitude)
            let $town := string($x/Town)
            let $state := string($x/State)
            let $country := string("Australia")
            let $name := string($x/Name)
            let $type := string($x/GeneralDetails/FacilityType)
            return
                <Toilet
                    Latitude="{$lat}"
                    Longitude="{$long}"
                    Town="{$town}"
                    State="{$state}"
                    Country="{$country}"
                    Name="{$name}"
                    FacilityType="{$type}"
                />
    }
</Toilets>
