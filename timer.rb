def timer(num=1)
	i = 0
	until i >= num
		g = 0
		h = []
		while g <= 1000
			h << '  ' * (h.length * g)
			g += 1
		end
		i+= 1
	end
end