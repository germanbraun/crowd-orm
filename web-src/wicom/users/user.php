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
    }

    /**
       Retrieve all model list from the DB.
     */
    function get_model_list(){
        return $this->model_list;
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
       Search on the model table of the DB for the user's tables.
       
       @return An array of strings with the model's names.
     */
    protected function retrieve_model_list(){
        
    }

    /**
       Search for the given user on the DB.
       
       @param $name The user's name to search.
       @return a User instance if exists, null otherwise.
     */
    public static function retrieve($name){
        
    }

        
}


?>
