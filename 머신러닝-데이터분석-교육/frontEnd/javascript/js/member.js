/* member.js */

Member = function(name, id, ssn){
    this.name = name;
    this.id = id;
    this.ssn = ssn;

};

Member.prototype.setValue = function(name, id, ssn){
    this.name = name;
    this.id = id;
    this.ssn = ssn;
};

Member.prototype.toString = function(){
    return this.name + "[" + this.id + "] :" + this.ssn;
};

