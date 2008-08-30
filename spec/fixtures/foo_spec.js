Screw.Unit(function() {
  describe("foo", function() {
    it("bar is true", function() {
      throw new Error('first test!');
      expect(foo.bar).to(be_true);
    });
    
    it("meh is false", function() {
      expect(foo.meh).to(be_false);
    });
    
    it("has a fail whale", function() {
      expect(foo.whale).to(be_false);
    });
    
    it("has a fail tail", function() {
      expect(foo.tail).to(be_undefined);
    });
    
    it("reports errors", function() {
      throw new Error('whoops!');
    });
  });
});

