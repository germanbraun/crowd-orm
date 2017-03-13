<?php 
/* 

   Copyright 2017 Giménez, Christian
   
   Author: Giménez, Christian   

   modeltest.php
   
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
load("model.php", "wicom/users/");

use Wicom\Users\User;
use Wicom\Users\Model;

class ModelTest extends PHPUnit_Framework_TestCase
{
    public function test_save(){
        $user = new User("alice", "alicepass");
        $user->save();

        $model = new Model("model_test", $user);

        $this->assertTrue($model->save());
    }

    public function test_retrieve(){
        $user = new User("alice", "alicepass");
        $user->save();
        $model = new Model("model_test", $user);
        $model->set_json("testing json information");
        $model->save();

        $model = Model::retrieve("model_test", "alice");

        $this->assertNotNull($model);
        $this->assertEquals("model_test", $model->get_name());
        $this->assertEquals("testing json information", $model->get_json());
    }
}
?>
