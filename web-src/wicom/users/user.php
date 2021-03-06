<?php 
/* 

   Copyright 2017 Giménez, Christian
   
   Author: Giménez, Christian   

   user.php
   
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

use Wicom\DB\DbConn;

/**
User Representation
 */
class User{
    protected $name = null;
    protected $pass = null;
    /**
       A string list of model names that the user owns.
     */
    protected $model_list = [];

    function __construct($name, $pass=null){
        $this->name = $name;
        $this->pass = $pass;
        $this->model_list = $this->retrieve_model_list();
        if (!$this->model_list){
            $this->model_list = [];
        }                       
    }

    /**
       @name Getters
     */
    ///@{
    function get_name(){
        return $this->name;
    }


    /**
       Retrieve all model list from the DB.

       @return Array of strings.
     */
    function get_model_list(){
        return $this->model_list;
    }
    ///@}

    /**
       Is the given password the same as the user's one?

       @param $pass a String
       @return true or false. 
     */
    function check_password($pass){
        return $this->pass == $pass;
    }

    /**
       Retrieve the user's model by its name. 

       @return A Model instance. null if it doesn't exists.
     */
    function get_model($name){
        //Chequear si es miembro
        
        //Retornar
        
    }

    /**
       @name Database related
    */
    ///@{   
    

    /**
       Search on the model table of the DB for the user's tables.
       
       @return An array of strings with the model's names. false if there was problems.
     */
    protected function retrieve_model_list(){
        $conn = new DbConn();
        $conn->query("SELECT name FROM model WHERE owner = '%s';", [$this->name]);
        $conn->close();
        
        return $conn->res_field("name");
    }

    /**
       Save or update the DB information regarded to this instance.

       @return true if saving or update was successful.
    */
    function save(){
        $conn = new DbConn();
        $conn->query("INSERT INTO users(name, pass) VALUES (\"%s\", \"%s\") ON DUPLICATE KEY UPDATE pass=\"%s\";",
                     [$this->name, $this->pass, $this->pass]);
        $conn->close();

        return $conn->get_last_results() != false;
    }

    /**
       Search for the given user on the DB.
       
       @param $name The user's name to search.
       @return a User instance if exists, null otherwise.
     */
    public static function retrieve($name){
        $conn = new DbConn();
        $conn->query("SELECT * FROM users WHERE name=\"%s\"", [$name]);       
        $conn->close();

        $row = $conn->res_nth_row(0);
        if (!$row){
            // No user founded!
            return null;
        }

        $user = new User($name, $row['pass']);
        return $user;
    }
    
    ///@}
}


?>
