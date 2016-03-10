This test are for storing and consulting Racer or other OWLlink reasoner. 

1. Start Racer ` ./Racer -- -protocol OWLlink`
2. Send example.xml.
3. Send query.xml to see what is stored.

You can send the files using the send.fish file or:

```bash
    curl -0 --data @example.xml http://127.0.1.1:8080
```

The XML files doesn't tell Racer to forget the KB, for that you have to send the `ReleaseKB` (see forget.xml).

## Executing Racer not as a Service

Execute: 

```
./Racer -- -protocol OWLlink -owllink PATH-TO-wicom/owllink-examples/example.xml
```
This will execute Racer without opening ports, and stoping as the OWLlink file is parsed. 

# OWL and OWLlink

Standards for consulting:

* [OWL Primer](https://www.w3.org/TR/2012/REC-owl2-primer-20121211/#OWL_Syntaxes)
* [OWLlink Structure](https://www.w3.org/Submission/2010/SUBM-owllink-structural-specification-20100701/#Introduction)
  * [Table of Requests and Responses](https://www.w3.org/Submission/2010/SUBM-owllink-structural-specification-20100701/#Table_of_Elements)

# Some OWL Clases
See the [OWL Syntaxes section](https://www.w3.org/TR/2012/REC-owl2-primer-20121211/#OWL_Syntaxes) and at the standard,

Check the [OWL IRI](http://www.w3.org/2002/07/owl) for more OWL predefined classes.

Don't forget to insert this XML part for importing OWL definitions

```xml
 <Prefix name="owl" IRI="http://www.w3.org/2002/07/owl#"/>
```

Or add this attribute to the `<RequestMessage>` tag:

```xml
xmlns:owl="http://www.w3.org/2002/07/owl#"
```

* `owl:Thing`
* `owl:Nothing`
