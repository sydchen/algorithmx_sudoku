module ExactCover
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
    y[r].reverse_each do |j|
      x.merge!(cols.pop())
      x[j].each do |i|
        for k in y[i]
          x[k] << i if k != j
        end
      end
    end
  end

  def solve(x, y, solution, &block)
    if x.empty?
      yield solution
      return true
    end

    #choose a column with minimum row cover
    c = x.min {|a, b| a[1].count <=> b[1].count }[0]
    for row in x[c]
      solution.push(row)
      cols = select(x, y, row)

      if solve(x, y, solution, &block)
        return true
      end
      deselect(x, y, row, cols)
      solution.pop
    end
    false
  end
end
