<?php 
/* 

   Copyright 2017 Giménez, Christian
   
   Author: Giménez, Christian   

   dbconn.php
   
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

namespace Wicom\DB;

use function \load;
load("config.php", "../../config/");

/**
   A DB connection.

   We obtain DB information from the config.php file.
 */
class DbConn{

    /**
       The DB connection. Needed by the mysql_connect() PHP function.
     */
    protected $conn = null;
    
    function __construct(){
        $this->create_tables();
        
        $this->conn = mysql_connect(
            $GLOBALS['db']['host'],
            $GLOBALS['db']['user'],
            $GLOBALS['db']['password']);
        if (!$this->conn){
            die('Could not connect to the DB. Ask your administrator.');
        }
    }

    /**
       Create all tables if don't exists.
     */
    function create_tables(){
        $dbname = $GLOBALS['db']['database'];
        mysql_query("CREATE DATABASE IF NOT EXISTS '$dbname'; use '$dbname';");
        mysql_query('CREATE TABLE IF NOT EXISTS users (name CHAR(20), pass CHAR(20), PRIMARY KEY (name));');
        mysql_query('CREATE TABLE IF NOT EXISTS model (name CHAR(20), owner CHAR(20), json LONGTEXT, PRIMARY KEY (name, owner), FOREIGN KEY (owner) REFERENCES users(name) );');
        
    }

    /**
       Send a query to the DB.

       @param $sql a String.
     */
    function query($sql){
        
        mysql_query('$sql');
    }
}
?>
