build_ship = function(s, w)
	if have 'грязь' and have 'палки' then
		p "Мы построили корабль!"
		remove(_"грязь")
		remove(_"палки")
		open "Корабль"
		return
	end
	p [[Так корабль не построить!]]
end

room {
	nam = 'пустошь';
	disp = "Пустошь";
	dsc = [[Вокруг вас пустынная местность.]];
	way = {path {'В корабль', "Корабль"} };
} :with {
	obj {
		nam = 'грязь';
		dsc = 'На столе лежит {грязь}.';
		inv = function(s)
			p 'Я съел грязь, из которой нужно было седелать корабль. :('
			remove(s); -- удалить яблоко из инвентаря
		end;
		tak = 'Вы взяли грязь.';
		use = build_ship;
	},
	obj {
		nam = 'палки';
		dsc = 'На столе лежат {палки}.';
		inv = function(s)
			p 'Я съел палки, из которых нужно было седелать корабль. :('
			remove(s); -- удалить яблоко из инвентаря
		end;
		tak = 'Вы взяли палки.';
		use = build_ship;
	},
	obj {
		nam = 'Барсик';
		myvar = 0; -- сколько раз Барсик осматривал местность
		{ -- не сохранять массив lf
			lf = {
				[1] = 'Барсик шевелится у меня за пазухой.',
				[2] = 'Барсик выглядывает из-за пазухи.',
				[3] = 'Барсик мурлычит у меня за пазухой.',
				[4] = 'Барсик дрожит у меня за пазухой.',
				[5] = 'Я чувствую тепло Барсика у себя за пазухой.',
				[6] = 'Барсик высовывает голову из-за пазухи и осматривает местность.',
			};
		};
		life = function(s)
			local r = rnd(5);
			if r > 2 then -- делать это не всегда
				return;
			end
			r = rnd(#s.lf); -- символ # -- число элементов в массиве
			p(s.lf[r]); -- выводим одно из 6 состояний Барсика
			if r == 6 then
				s.expect = s.myvar+1;
			end;
		end;
		dsc = "Рядом проплывает {Барсик}, его можно взять с собой.";
		tak = function(s) 
			p "Вы взяли Барсика";
			lifeon("Барсик");
		end;
		inv = "Вы погладили Барсика. Барсику понравилось!";
	}
}
