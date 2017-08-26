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

use function \preg_match;
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
    
    protected $owllink_text = "";

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
       
       Abbreviated IRIs are recognized automatically.

       @param child_class A String with the child's name class.
       @param father_class Same as $child_class parameter but for 
       the $father_class.
       @param child_abbrev If true, force the abbreviated IRI for the
       child class; if false, force the (not abbreviated) IRI; if 
       null check it automatically.
       @param father_abbrev same as $child_abbrev but for the 
       $father_class. 
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
       Check if this IRI has a namespace, (i.e.: is an
       abbreviated IRI).

       Like in "owl:Thing" which its namespace is "owl" here.

       @param name a String with the IRI.
       @return True if the name has an XML Namespace. False otherwise.
    */
    protected function name_has_namespace($name){
        $ns_regexp = '/.*:.*/';        // Namespace Regexp.
        
        if (preg_match($ns_regexp, $name) > 0){
            return true;
        }else{
            return false;
        }
    }
  
    /**
       Add a class DL element.

       Abbreviated IRI's are recognized automatically by name_has_namespace() function.

       @param name String the name or IRI of the new concept.
       @param is_abbreviated Boolean (Optional) force that the given IRI is or is not an abreviated like <tt>owl:class</tt>.
     */
    public function insert_class($name, $is_abbreviated=null){
        if (! $this->in_tell){
            // We're not in tell mode!!!
            return false;
        }

        if ($is_abbreviated == null){
            // Is abbreviated is not forced, so check namepsace
            // presence...
            $is_abbreviated = $this->name_has_namespace($name);
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

    public function begin_inverseof(){
        $this->content->startElement("owl:ObjectInverseOf");
    }
    public function end_inverseof(){
        $this->content->EndElement();
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

    public function begin_unionof(){
        $this->content->startElement("owl:ObjectUnionOf");
    }
    public function end_unionof(){
        $this->content->EndElement();
    }

    public function begin_complementof(){
        $this->content->startElement("owl:ObjectComplementOf");
    }
    public function end_complementof(){
        $this->content->EndElement();
    }
    
    public function begin_somevaluesfrom(){
        $this->content->startElement("owl:ObjectSomeValuesFrom");
    }
    public function end_somevaluesfrom(){
        $this->content->EndElement();
    }

    public function begin_allvaluesfrom(){
        $this->content->startElement("owl:ObjectAllValuesFrom");
    }
    public function end_allvaluesfrom(){
        $this->content->EndElement();
    }
    
    public function begin_mincardinality($cardinality){
        $this->content->startElement("owl:ObjectMinCardinality");
        $this->content->writeAttribute("cardinality", $cardinality);
    }
    public function end_mincardinality(){
        $this->content->EndElement();
    }
    public function begin_maxcardinality($cardinality){
        $this->content->startElement("owl:ObjectMaxCardinality");
        $this->content->writeAttribute("cardinality", $cardinality);
    }
    public function end_maxcardinality(){
        $this->content->EndElement();
    }

	public function begin_objectpropertydomain(){
		$this->content->startElement("owl:ObjectPropertyDomain");        
	}
        
   	public function end_objectpropertydomain(){
        $this->content->EndElement();
	}

	public function begin_objectpropertyrange(){
		$this->content->startElement("owl:ObjectPropertyRange");        
	}
        
   	public function end_objectpropertyrange(){
        $this->content->EndElement();
	}

	public function begin_equivalentclasses(){
		$this->content->startElement("owl:EquivalentClasses");        
	}
        
   	public function end_equivalentclasses(){
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

    /**
       Insert an ASK query denominated IsEntailedDirect for all the classes in the array.

       @param $array An array of Strings with classnames.
     */
    public function insert_equivalent_class_query($array){
        $this->content->startElement("IsEntailedDirect");
        $this->content->writeAttribute("kb", $this->actual_kb);

        $this->content->startelement("owl:EquivalentClasses");
        foreach ($array as $classname){
            $this->content->startElement("owl:Class");
            $this->content->writeAttribute("IRI", "#" . $classname);
            $this->content->endElement();
        }
        $this->content->endElement();        
        
        $this->content->endElement();
    }
    
    ///@}
    // Ask group.

    public function insert_owllink($text){
        // $this->owllink_text = $text;
        $this->content->writeRaw($text);
        
    }

    public function to_string(){
        $str = $this->content->outputMemory();
        // $str = str_replace(
        //     "</RequestMessage>",
        //     $this->owllink_text . "</RequestMessage>",
        //     $str);
        return $str;
    }
}

?>
