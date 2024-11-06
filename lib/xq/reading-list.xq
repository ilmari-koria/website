declare option output:indent "yes";

let $file := file:read-text(file:resolve-path('./tmp/xml/reading-list/reading-list.csv'))
let $csv := csv:parse($file, { 'header': true() })

let $all-books := 
  for $record in $csv//record
    let $startedReading := $record/Started_Reading
    let $finishedReading := $record/Finished_Reading/data()
    where (string-length($startedReading) > 0) and
          (string-length($finishedReading) > 0 or string-length($startedReading) > 0)
    let $xml :=
      <book>
        {$record/ISBN-13}
        {$record/Title}
        {$record/Authors}
        {$record/Publication_Date}
        {$startedReading}
        <Finished_Reading>{
          if (string-length($finishedReading) > 0) then
            $finishedReading
          else
            'current'
          }
        </Finished_Reading>
      </book>
    return $xml

let $all-books-xml := <books>{ $all-books }</books>
return
  file:write(file:resolve-path("./tmp/xml/reading-list/reading-list.xml"), $all-books-xml)

    


