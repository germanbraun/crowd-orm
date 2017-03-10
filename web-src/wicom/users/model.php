<?php 
/* 

   Copyright 2017 Giménez, Christian
   
   Author: Giménez, Christian   

   model.php
   
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

namespace Wicom\Users;

use function \load;
load("dbconn.php", "../db/");
load("user.php");

use Wicom\DB\DbConn;
use Wicom\Users\User;

/**
   A user Model.

   @todo For now a UML model, however it should have subclass for each type of graphical language.
 */
class Model {
    /**
       Name of the model.
     */
    protected $name = null;
    /**
       Owner of the model. A User instance.
     */
    protected $owner = null;
    /**
       JSON that represent the model for the user interface.
     */
    protected $json = null;

    /**
       @param $owner a User instance.
       @param $name a String instance
     */
    function __construct($name, $owner){
        $this->name = $name;
        $this->owner = $owner;
    }

    /**
       @name Getters
     */
    ///@{    
    function get_name(){
        return $this->name;
    }
    
    function get_owner(){
        return $this->owner;
    }
    
    function get_json(){
        return $this->json;
    }
    ///@}
    
    function set_json($json){
        $this->json = $json;
    }


    /**
       @name Database related
     */
    ///@{
    
    /**
       Save into the DB.
     */
    function save(){
        // Save or update the owner if it doesn't exists
        $this->owner->save();
        
        $conn = new DbConn();
        $conn->query(
            "INSERT INTO model(name, owner, json) VALUES \"%s\", \"%s\", \"%s\" ON DUPLICATE KEY UPDATE json=\"%s\";",
            [$this->name, $this->owner->get_name(), $this->json]);        
        $conn->close();
    }

    /**
       Update the json from the DB.
     */
    function update(){
    }
    
    /**
       Retrieve from the database the Model given by the name and its owner.

       @param $name a String.
       @param $owner_name a String.
       @return a Model instance or null if it doesn't exists.
     */
    public static function retrieve($name, $owner_name){
        $conn = new DbConn();
        $conn->query("SELECT * FROM models WHERE name=\"%s\" AND owner=\"%s\";" , [$name, $owner_name]);
        $conn->close();
        
        $row = $conn->res_nth_row(0);
        if (!$row) {
            // No model founded.
            return null;
        }

        // Search for owner.
        $owner = User::retrieve($owner_name);
        if ($owner == null){
            // Doesn't exists any wwner with that name
            return null;
        }

        // Create instance and return it
        $model = new Model($name, $owner);
        $model->set_json($row['json']);
        
       
        return $model;
    }

    ///@}
    
}

?>
