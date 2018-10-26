//data valid states
var FieldStates = Object.freeze({ "ERROR": 0, "VALID": 1 });

class FieldControl {
    constructor(name, isRequired, rangeStart, rangeEnd, regexTestString, infoText) {
        this.name = name;
        this.isRequired = isRequired;
        this.rangeStart = rangeStart;
        this.rangeEnd = rangeEnd;
        this.regexTestString = regexTestString;
        this.infoText = infoText;
    }
}
