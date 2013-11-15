(function() {
  describe('amara', function() {
    return it('Mixed dependencies', function(done) {
      define('a', function() {
        return 1;
      });
      define('b', function() {
        return 2;
      });
      define('c', ['a', 'b'], function(a, b) {
        return a + b;
      });
      define('d', ['c', 'b', 'a'], function(c, b, a) {
        return c * (b + a);
      });
      define('e', ['d'], function(d) {
        return d * 3;
      });
      return require(['e'], function(e) {
        expect(e).to.be.a('number');
        expect(e).to.equal(27);
        return done();
      });
    });
  });

}).call(this);
