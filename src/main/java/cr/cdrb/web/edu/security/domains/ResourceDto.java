/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cr.cdrb.web.edu.security.domains;

/**
 *
 * @author Jayang
 */
public class ResourceDto  extends Resource {

        private int _parentId;

        public int get__parentId() {
            return this._parentId;
        }

        public void set__parentId(int _parentId) {
            this._parentId = _parentId;
        }     
}
