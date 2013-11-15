describe 'amara', ->
  
  it 'Mixed dependencies', (done) ->
    define 'a', -> 1
    define 'b', -> 2
    define 'c', ['a', 'b'], (a, b) -> a + b
    define 'd', ['c', 'b', 'a'], (c, b, a) -> c * (b + a)
    define 'e', ['d'], (d) -> d * 3
     
    require ['e'], (e) ->
      expect(e).to.be.a 'number'
      expect(e).to.equal 27
      done()
