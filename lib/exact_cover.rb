module ExactCover
  DEBUG = false

  def select(x, y ,r)
    cols = []
    for j in y[r]
      for i in x[j]
        for k in y[i]
          x[k].delete(i) if k != j
        end
      end
      cols << x.select {|c| c == j }
      x.delete(j)
    end
    cols
  end

  def deselect(x, y, r, cols)
    puts "unselect row #{r}" if DEBUG
    y[r].reverse_each do |j|
      x.merge!(cols.pop())
      x[j].each do |i|
        for k in y[i]
          x[k] << i if k != j
        end
      end
    end
  end

  def solve(x, y, solution)
    if x.empty?
      return true
    end

    #choose a column with minimum row cover
    c = x.min {|a, b| a[1].count <=> b[1].count }[0]
    puts "select column #{c}" if DEBUG
    for row in x[c]
      puts "pick row #{row}" if DEBUG
      solution.push(row)
      cols = select(x, y, row)
      puts "after x: #{x}" if DEBUG
      puts "cols #{cols}" if DEBUG
      ret = solve(x, y, solution)
      return ret if ret
      deselect(x, y, row, cols)
      solution.pop
    end
    false
  end
end
