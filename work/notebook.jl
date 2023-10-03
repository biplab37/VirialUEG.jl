### A Pluto.jl notebook ###
# v0.19.27

using Markdown
using InteractiveUtils

# ╔═╡ 7c3401fe-612b-11ee-2122-cf64fa2a3a00
begin
	using Pkg;
	Pkg.activate()
	using Plots, Revise, VirialUEG, LaTeXStrings
	gr()
end

# ╔═╡ 6381ec6e-1852-45d5-966d-a753fe4e54e0
using DelimitedFiles

# ╔═╡ cd3aea1c-f261-4177-8334-09da3ce1af7f
using PGFPlotsX

# ╔═╡ eef8e69d-8407-41b7-9aa8-db7183a64531
temp = T(20,128)

# ╔═╡ ee214bdc-a81a-4b68-a865-cd2929612b61
begin
	nrange = 4e-7:1e-7:1e-3
	rrange = rr.(nrange)
	thetarange = theta.(rrange, temp)
	xaxis = [sqrt(n)*log((4π*n)/temp^2) for n in nrange]
	yaxis = [ v2_eff(virial_interp, r , θ) for (r, θ) in zip(rrange, thetarange)]
end;

# ╔═╡ 5af76b24-a51c-4b7c-bcb1-8d6ba3d42778
begin
	data = zip(xaxis,yaxis)
	open("delim_file.txt", "w") do io
		writedlm(io, data, ",")
	end
end

# ╔═╡ b93c81a9-16e7-4f58-b2a6-799aed2919b4
v2eff(v,r,θ) = v2_eff((r,θ)->v,r,θ)

# ╔═╡ 2ab0779e-19c2-4a98-b3e8-056c72dda745
v2_eff(virial_interp, 20,128)

# ╔═╡ 31430bf7-1adc-4841-b343-893cd689bb02
n(20)

# ╔═╡ 08b828f5-5c3f-4c45-91a9-0a7c1c3fea64
n(40)

# ╔═╡ a83b4802-33b1-4237-a039-74fe28f9eddf
n(2)

# ╔═╡ 1d605245-2548-4e92-b401-8867024c5531
ff(r,th) = -0.030854464445

# ╔═╡ 141dd20d-ad03-4994-bb2e-7c12fd710753
v2_eff(ff,2,217.204)

# ╔═╡ f304a9c6-56c7-4a98-9169-0ba3ace784f5
virial_interp(0.08,0.347527)

# ╔═╡ c5d3e8c7-724b-4d8b-81d1-d9afd766b7ea
v2_eff(virial_interp, 20,128)

# ╔═╡ 886cb8e8-5a9f-41e2-b0ff-860abd3e5237
xx(n,tt) = sqrt(n)*log(4π*n/tt^2)

# ╔═╡ 15b74a11-c583-47a3-9359-c3e0f0069d72
begin
	plot(xaxis, yaxis, label="Interpolation", l=2)
	scatter!([xx(n(20),temp)], [v2eff(-0.011929,20,128)], label="PIMC", color=:red)
	scatter!([xx(n(40),temp)], [v2eff(-0.0043404, 40, 512)], yerr = (v2eff(-0.0043404,40,512)-v2eff(-0.0043404 - 0.0000086, 40, 512)), color=:red, label="")
	plot!(xlabel=L"$\sqrt{n} \ln(4\pi n/T^2)$", ylabel=L"$v_2^{eff}$")
end

# ╔═╡ 7b8227c3-87a7-4049-acf5-5c2bd4a8ce20
xx(n(20),temp)

# ╔═╡ 30ef1749-fba0-40f4-9f3d-4412a5e24341
begin
	n2range = 1e-7:1e-7:4e-4;
	r2range = rr.(n2range);
	temp2 = T(20,64)
	theta2range = theta.(r2range, temp2)
	x2axis = [sqrt(n)*log((4π*n)/temp2^2) for n in n2range]
	y2axis = [v2_eff(virial_interp, r , θ) for (r, θ) in zip(r2range, theta2range)]
end

# ╔═╡ 0e5edab5-70b4-4249-8f24-c78e5892acdd
begin
	plot(x2axis, y2axis, label="Interpolation", l=2)
	scatter!([xx(n(20),temp2)], [v2eff(-0.016005,20,64)], label="PIMC", color=:red)
	scatter!([xx(n(40),temp2)], [v2eff(-0.00597188, 40, 256)], yerr = (v2eff(-0.00597188,40,256)-v2eff(-0.00597188 - 0.00001116, 40, 256)), color=:red, label="")
	plot!(xlabel=L"$\sqrt{n} \ln(4\pi n/T^2)$", ylabel=L"$v_2^{eff}$")
end

# ╔═╡ b5e535fc-13d3-4c05-85d0-d9d37e9e12c4
begin
	n3range = 1e-5:1e-4:1.2;
	r3range = rr.(n3range);
	temp3 = T(2,217.204)
	theta3range = theta.(r3range, temp3)
	x3axis = [sqrt(n)*log((4π*n)/temp3^2) for n in n3range]
	y3axis = [v2_eff(virial_interp, r , θ) for (r, θ) in zip(r3range, theta3range)]
end

# ╔═╡ 9eee45da-9526-4598-b98a-1da91667146e
begin
	plot(x3axis, y3axis, label="Interpolation", l=2)
	# scatter!([xx(n(2))], [v2eff(-0.016005,20,64)], label="PIMC", color=:red)
	# scatter!([xx(n(40))], [v2eff(-0.00597188, 40, 256)], yerr = (v2eff(-0.00597188,40,256)-v2eff(-0.00597188 - 0.00001116, 40, 256)), color=:red, label="")
	plot!(xlabel=L"$\sqrt{n} \ln(4\pi n/T^2)$", ylabel=L"$v_2^{eff}$")
end

# ╔═╡ ec7a8bed-9853-4ab7-b5eb-991f95ed1a21
VirialUEG.v2(0.589307)

# ╔═╡ bd82bf9a-0820-4d25-a860-f27255958851
linear(x) = VirialUEG.v2(temp) - x*VirialUEG.v3(temp)

# ╔═╡ 704bc482-98dd-46a5-8c07-e03826ef73ca
p = @pgf Axis(
	{
		xlabel = L"-\sqrt{n_B}\ln(4\pi n_B/T_{\textrm{Ha}}^2)",
		ylabel = L"v_2^{\textrm{eff}}",
		height = "7cm",
		width = "11cm",
		tick_label_style = "/pgf/number format/fixed",
		xmin=0.0,
		legend_pos = "south east"
	},
	PlotInc({
		no_marks
	},
		Table(
			-xaxis, yaxis
		)
),
LegendEntry("Interpolation"),
PlotInc(
	{
	"only marks",
    "error bars/y dir=both",
    "error bars/y explicit",
	},
	Coordinates(
		[-xx(n(20),temp), -xx(n(40),temp)], 
		[v2eff(-0.011929,20,128),v2eff(-0.0043404, 40, 512)],
		yerror = [0.0, (v2eff(-0.0043404,40,512)-v2eff(-0.0043404 - 0.0000086, 40, 512))]
	)
),
LegendEntry("PIMC"),
PlotInc(
	{
	no_marks,
	dashed
	},
	Coordinates(
		[0.0, 0.07],
		[linear(0.0), linear(0.07)]
	)
),
LegendEntry("virial 2+3"),
PlotInc({
	mark = "*"

},
	Coordinates(
		[0.0], [linear(0.0)]
	)
),
[raw"\node ", " at ", Coordinate(0.06,-5),"{\$T_{Ha}\$=$(round(temp,digits=3))};"]
)

# ╔═╡ a8872867-2aec-45a0-b5bb-31261c7a7529
linear2(x) = VirialUEG.v2(temp2) - x*VirialUEG.v3(temp2)

# ╔═╡ a1e45b34-a6c0-4c19-88b2-3499cdc54a0e
pgfsave("figure1.pdf",p)

# ╔═╡ 3ddf49bf-92dc-45d7-8dab-49c98bc2cdc4
p2 = @pgf Axis(
	{
		xlabel = L"-\sqrt{n_B}\ln(4\pi n_B/T_{\textrm{Ha}}^2)",
		ylabel = L"v_2^{\textrm{eff}}",
		height = "7cm",
		width = "11cm",
		scaled_ticks = false,
		tick_label_style = "/pgf/number format/fixed",
		xmin=0.0,
		legend_pos = "south east"
	},
	PlotInc({
		no_marks
	},
		Table(
			-x2axis, y2axis
		)
),
LegendEntry("Interpolation"),
PlotInc(
	{
	"only marks",
    "error bars/y dir=both",
    "error bars/y explicit",
	},
	Coordinates(
		[-xx(n(20),temp2), -xx(n(40),temp2)], 
		[v2eff(-0.016005,20,64),v2eff(-0.00597188, 40, 256)],
		yerror = [0.0, (v2eff(-0.00597188,40,256)-v2eff(-0.00597188 - 0.00001116, 40, 256))]
	)
),
LegendEntry("PIMC"),
PlotInc(
	{
	no_marks,
dashed
	},
	Coordinates(
		[0.0, 0.05],
		[linear2(0.0), linear2(0.05)]
	)
),
LegendEntry("virial 2+3"),
PlotInc({
	mark = "*"

},
	Coordinates(
		[0.0], [linear2(0.0)]
	)
),
[raw"\node ", " at ", Coordinate(0.03,-25),"{\$T_{Ha}\$=$(round(temp2,digits=3))};"]
)

# ╔═╡ 646ebb6e-524a-4521-bc11-1ad68e8875bf
pgfsave("figure2.pdf",p2)

# ╔═╡ 6fdf6faa-3706-4549-8e63-a288cd922cbe
md"## Figure 3"

# ╔═╡ e3acbc5a-31cc-4030-844f-093b6cb60566
linear3(x) = VirialUEG.v2(temp3) - x*VirialUEG.v3(temp3)

# ╔═╡ 47b6f1b7-d45a-4b45-bf9d-bb691a26bb9a
p3 = @pgf Axis(
	{
		xlabel = L"-\sqrt{n_B}\ln(4\pi n_B/T_\textrm{Ha}^2)",
		ylabel = L"v_2^{\textrm{eff}}",
		height = "7cm",
		width = "11cm",
		# scaled_ticks = false,
		# tick_label_style = "/pgf/number format/fixed",
		xmin=0.0,
		xmax = 7.0,
		legend_pos = "south east"
	},
	PlotInc({
		no_marks
	},
		Table(
			-x3axis, y3axis
		)
),
LegendEntry("Interpolation"),
PlotInc(
	{
	"only marks",
    "error bars/y dir=both",
    "error bars/y explicit",
	},
	Coordinates(
		[-xx(n(2),temp3)], 
		[v2eff(-0.030854464445,2,217.204)],
		yerror = [(v2eff(-0.030854464445,2,217.204)-v2eff(-0.030854464445 - 0.00006612,2,217.204))]
	)
),
LegendEntry("PIMC"),
PlotInc(
	{
	dashed,
	no_marks
	},
	Coordinates(
		[0.0, 3.0],
		[linear3(0.0), linear3(3.0)]
	)
),
LegendEntry("virial 2+3"),
PlotInc({
	mark = "*"

},
	Coordinates(
		[0.0], [linear3(0.0)]
	)
),
[raw"\node ", " at ", Coordinate(3.5,-0.008),"{\$T_{Ha}\$ = 100};"]
)

# ╔═╡ 751d8e62-0207-41a6-96d4-4509cf81023b
pgfsave("figure3.pdf",p3)

# ╔═╡ 0c6ef315-bd2f-433f-8a0f-4d259528b641
md"### V3"

# ╔═╡ e526856c-c211-400f-ae7e-10b3293cead2
begin
	temp4 = T(2,217.204)
	n4range = exp.( 5.7:-1e-2:-5)
	r4range = rr.(n4range);
	theta4range = theta.(r4range, temp4)
	x4axis = [1/log((4π*n)/temp4^2) for n in n4range]
	y4axis = [v3_eff(virial_interp, r , θ) for (r, θ) in zip(r4range, theta4range)]
end

# ╔═╡ 5f7d2903-2f83-4d0e-82c1-5b911a58ebd9
linear4(x) =  VirialUEG.v3(temp4) - x*0.00038

# ╔═╡ 5b9d1f5a-501f-42a0-97fa-11fd87eb28cf
p4 = @pgf Axis(
	{
		xlabel = L"-1/\ln(4\pi n_B/T_{\textrm{Ha}}^2)",
		ylabel = L"v_3^{\textrm{eff}}",
		height = "7cm",
		width = "11cm",
		# scaled_ticks = false,
		# tick_label_style = "/pgf/number format/fixed",
		xmin=0.0,
xmax=1.0,
		legend_pos = "north east"
	},
	PlotInc({
		no_marks,
		thick
	},
		Table(
			-x4axis, y4axis
		)
),
LegendEntry("Interpolation"),
PlotInc(
	{
	"only marks",
    "error bars/y dir=both",
    "error bars/y explicit"
	},
	Coordinates(
		[- 1.0/log(4π*n(2)/temp4^2)], 
		[v3_eff((r,θ)->-0.030854464445,2,217.204)],
		yerror = [(v3_eff((r,θ)->-0.030854464445,2,217.204) - v3_eff((r,θ)->-0.030854464445 -0.00006612,2,217.204))]
	)
),
LegendEntry("PIMC"),
PlotInc(
	{
	thin,
	black,
	no_marks
	},
	Coordinates(
		[0.0, 1.0],
		[linear4(0.0), linear4(1.0)]
	)
),
LegendEntry("virial 2+3"),
PlotInc({
	mark = "*"

},
	Coordinates(
		[0.0], [linear4(0.0)]
	)
),
[raw"\node ", " at ", Coordinate(0.4,0.001),"{\$T_{Ha}\$ = 100};"]

)

# ╔═╡ 74364cf1-e9f8-4b83-a616-1d6145151e37
pgfsave("figure4.pdf",p4)

# ╔═╡ Cell order:
# ╠═7c3401fe-612b-11ee-2122-cf64fa2a3a00
# ╠═eef8e69d-8407-41b7-9aa8-db7183a64531
# ╠═ee214bdc-a81a-4b68-a865-cd2929612b61
# ╠═15b74a11-c583-47a3-9359-c3e0f0069d72
# ╠═6381ec6e-1852-45d5-966d-a753fe4e54e0
# ╠═5af76b24-a51c-4b7c-bcb1-8d6ba3d42778
# ╠═b93c81a9-16e7-4f58-b2a6-799aed2919b4
# ╠═2ab0779e-19c2-4a98-b3e8-056c72dda745
# ╠═31430bf7-1adc-4841-b343-893cd689bb02
# ╠═08b828f5-5c3f-4c45-91a9-0a7c1c3fea64
# ╠═a83b4802-33b1-4237-a039-74fe28f9eddf
# ╠═1d605245-2548-4e92-b401-8867024c5531
# ╠═141dd20d-ad03-4994-bb2e-7c12fd710753
# ╠═f304a9c6-56c7-4a98-9169-0ba3ace784f5
# ╠═c5d3e8c7-724b-4d8b-81d1-d9afd766b7ea
# ╠═886cb8e8-5a9f-41e2-b0ff-860abd3e5237
# ╠═7b8227c3-87a7-4049-acf5-5c2bd4a8ce20
# ╠═30ef1749-fba0-40f4-9f3d-4412a5e24341
# ╟─0e5edab5-70b4-4249-8f24-c78e5892acdd
# ╠═b5e535fc-13d3-4c05-85d0-d9d37e9e12c4
# ╠═9eee45da-9526-4598-b98a-1da91667146e
# ╠═ec7a8bed-9853-4ab7-b5eb-991f95ed1a21
# ╠═cd3aea1c-f261-4177-8334-09da3ce1af7f
# ╠═704bc482-98dd-46a5-8c07-e03826ef73ca
# ╠═bd82bf9a-0820-4d25-a860-f27255958851
# ╠═a8872867-2aec-45a0-b5bb-31261c7a7529
# ╠═a1e45b34-a6c0-4c19-88b2-3499cdc54a0e
# ╠═3ddf49bf-92dc-45d7-8dab-49c98bc2cdc4
# ╠═646ebb6e-524a-4521-bc11-1ad68e8875bf
# ╟─6fdf6faa-3706-4549-8e63-a288cd922cbe
# ╠═e3acbc5a-31cc-4030-844f-093b6cb60566
# ╠═47b6f1b7-d45a-4b45-bf9d-bb691a26bb9a
# ╠═751d8e62-0207-41a6-96d4-4509cf81023b
# ╠═0c6ef315-bd2f-433f-8a0f-4d259528b641
# ╠═e526856c-c211-400f-ae7e-10b3293cead2
# ╠═5f7d2903-2f83-4d0e-82c1-5b911a58ebd9
# ╠═5b9d1f5a-501f-42a0-97fa-11fd87eb28cf
# ╠═74364cf1-e9f8-4b83-a616-1d6145151e37
