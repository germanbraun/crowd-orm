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

require_once("common.php");

// use function \load;
load("config.php", "config/");
load("user.php", "wicom/users/");

use Wicom\Users\User;

class UserTest extends PHPUnit_Framework_TestCase
{

    /**
       Try to test User::save() function.

       Remember, if User::retrieve() doesn't work properly, then this test may fail.
     */
    public function test_save(){
        $user = new User("alice", "alicepass");
        $user->save();

        $user_b = User::retrieve("alice");

        // Careful with this, == in PHP compares each variable, === is object identity.
        $this->assertEquals($user, $user_b, true);
    }

    /**
       Try to test the retrieve static function. 

       Remember, if User::save() doesn't work properly, this function will fail.
     */
    public function test_retrieve(){
        $user = new User("alice", "alicepass");
        $user->save();
        
        $user = User::retrieve("alice");

        $this->assertEquals($user->get_name(), "alice");
        $this->assertTrue($user->check_password("alicepass"));
    }
}
?>
