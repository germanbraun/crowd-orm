<?php 
/* 

   Copyright 2016 Giménez, Christian
   
   Author: Giménez, Christian   

   owllinkdocument.php
   
   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.
   
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.
   
   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

namespace Wicom\Translator\Documents;

use function \load;
load('document.php');

use \XMLWriter;

/**

   # Example

   @code{.php}
   $d = new OWLlinkDocument();
   $d->insert_startdocument();
   $d->insert_request();
   
   // ...

   $d->end_document();

   $d->to_string();
   @endcode
   
 */
class OWLlinkDocument extends Document{
    protected $content = null;

    /**
       The current KB URI as \i. of String.
       

       This can be changed by creating a new KB 
       (see insert_create_kb()) or by using the setter.
              
     */
    protected $actual_kb = null;

    /**
       I'm inserting Tell's queries?
    */
    protected $in_tell = false;
    


    public function set_actual_kb($kb_uri){
        $this->actual_kb = $kb_uri;
    }

    function __construct(){
        $this->content = new XMLWriter();
        $this->content->openMemory();

        $this->in_tell = false;
    }

    /**
       @name Starting and Ending the document
    */
    ///@{
    
    public function insert_startdocument(){
        $this->content->startDocument("1.0", "UTF-8");
    }

    public function insert_request(){        
        $this->content->startElement("RequestMessage");
        $this->content->writeAttribute("xmlns", "http://www.owllink.org/owllink#");
        $this->content->writeAttribute("xmlns:owl", "http://www.w3.org/2002/07/owl#" );
		$this->content->writeAttribute("xmlns:xsi", "http://www.w3.org/2001/XMLSchema-instance");
		$this->content->writeAttribute("xsi:schemaLocation", "http://www.owllink.org/owllink# http://www.owllink.org/owllink-20091116.xsd");
    }

    /**
       Abbreviation of:

       @code{.php}
       $d->insert_startdocument();
       $d->insert_request();
       @endcode
     */
    public function start_document(){
        $this->insert_startdocument();
        $this->insert_request();
    }
    
    public function end_document(){
        if ($this->in_tell) {
            $this->end_tell();
        }
        $this->content->endElement();
    }

    ///@}
    // Starting and ending the document 

    public function insert_prefix($uri){
    }

    /**
       @name KB Management Messages

       These messages is used for insert OWLlink's primitives for 
       manage Knowldege Bases.
    */
    //@{

    /**
       Insert a "CreateKB" OWLlink primitive. After that, set the 
       actual_kb to the given URI.

       @param uri String. The name or the URI of the KB.
     */
    public function insert_create_kb($uri){
        $this->content->startElement("CreateKB");
        $this->content->writeAttribute("kb",$uri);
        //$this->content->text("");
        $this->content->endElement();
        
        $this->actual_kb = $uri;
    }

    /**
       Insert a "ReleaseKB" OWLlink primitive. 

       If the URI corresponds to the actual_kb one, set it to null.
       
       @param uri String (Optional). The name or the URI of the 
       database to release. If not given, use the actual_kb one.
     */
    public function insert_release_kb($uri=null){
        if ($uri == null){
            $uri = $this->actual_kb;
        }

        $this->content->startElement("ReleaseKB");
        $this->content->writeAttribute("kb", $uri);
        $this->content->endElement();

        // $uri can be given by parameter or setted by this methods
        // when $uri is null (or not given).
        // Whenever be the case, it should be checked if it is the
        // same as actual_kb.
        if ($uri == $this->actual_kb) {
            $this->actual_kb = null;
        }
        
    }

    ///@}
    // KB Management.

    /**
       @name Tell

       Messages for adding Tell queries into the OWLlink document.       
    */
    ///@{
    
    public function get_in_tell(){
        return $this->in_tell;
    }
    
    /**
       Open e Tell query.

       The KB is setted according to actual_kb.

       Example:
       
       @code{.php}
       $owllink_document->start_tell();
       $owllink_document->insert_concept("Person");
       $owllink_document->insert_concept("OtherPerson");
       $owllink_document->end_tell();
       @endcode
     */
    public function start_tell(){
        $this->content->startElement("Tell");
        $this->content->writeAttribute("kb", $this->actual_kb);
        $this->in_tell = true;
    }
    
    public function end_tell(){
        if ($this->in_tell){
            $this->content->endElement();
            $this->in_tell = false;
        }
    }
    

/**
       Insert a DL subclass-of operator. 
     */
    public function insert_subclassof($child_class, $father_class, $child_abbrev=false, $father_abbrev=false){
        if (! $this->in_tell){
            return false;
        }
        $this->content->startElement("owl:SubClassOf");
        $this->insert_class($child_class, $child_abbrev);
        $this->insert_class($father_class, $father_abbrev);
        $this->content->endElement();
    }

  
    /**
       Add a class DL element.

       @param name String the name or IRI of the new concept.
       @param is_abbreviated Boolean (Optional) if the given IRI is an abreviated like <tt>owl:class</tt>.
     */
    public function insert_class($name, $is_abbreviated=false){
        if (! $this->in_tell){
            return false;
        }
        $this->content->startElement("owl:Class");
        if ($is_abbreviated){
            $this->content->writeAttribute("abbreviatedIRI", $name);
        }else{
            $this->content->writeAttribute("IRI", $name);
        }
        $this->content->endElement();
    }

    public function insert_objectproperty($name){
        $this->content->startElement("owl:ObjectProperty");        
        $this->content->writeAttribute("IRI", $name);
        $this->content->endElement();
    }
    public function begin_subclassof(){
        $this->content->startElement("owl:SubClassOf");
    }
    public function end_subclassof(){
        $this->content->EndElement();
    }
    public function begin_intersectionof(){
        $this->content->startElement("owl:ObjectIntersectionOf");
    }
    public function end_intersectionof(){
        $this->content->EndElement();
    }
    public function begin_somevaluesfrom(){
        $this->content->startElement("owl:ObjectSomeValuesFrom");
    }
    public function end_somevaluesfrom(){
        $this->content->EndElement();
    }
    public function begin_mincardinality($cardinality){
        $this->content->startElement("owl:ObjectMinCardinality");
        $this->content->writeAttribute("cardinality", $cardinality);
    }
    public function end_mincardinality($cardinality){
        $this->content->EndElement();
    }
    public function begin_maxcardinality($cardinality){
        $this->content->startElement("owl:ObjectMaxCardinality");
        $this->content->writeAttribute("cardinality", $cardinality);
    }
    public function end_maxcardinality($cardinality){
        $this->content->EndElement();
    }
        
    
    ///@}
    // Tell group.

    /**
       @name Ask 

       Messages for the Ask section.
     */
    ///@{
    
    public function insert_satisfiable(){
        $this->content->startElement("IsKBSatisfiable");
        $this->content->writeAttribute("kb", $this->actual_kb);
        $this->content->endElement();
    }

    public function insert_satisfiable_class($classname){
        $this->content->startElement("IsClassSatisfiable");        
        $this->content->writeAttribute("kb", $this->actual_kb);
        
        $this->content->startElement("owl:Class");
        $this->content->writeAttribute("IRI", $classname);
        $this->content->endElement();
        
        $this->content->endElement();
    }
    
    ///@}
    // Ask group.

    public function to_string(){
        return $this->content->outputMemory();
    }
}

?>
