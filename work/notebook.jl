### A Pluto.jl notebook ###
# v0.19.29

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

# ╔═╡ f3833fa6-6e92-4656-9af0-35a838143e52
using EasyFit

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

# ╔═╡ 4d870e03-a69c-4162-8088-545eb9199594
T(12.5, 50)

# ╔═╡ 0d859187-d70a-40a9-b959-fd8ae448abd7
v2eff(-0.0233818166902136, 12.5, 50)

# ╔═╡ 87b66793-079e-4a2c-9c69-774a622a9abe
			[-xx(n(20),temp), -xx(n(40),temp)], 
			[v2eff(-0.011929,20,128),v2eff(-0.0043404, 40, 512)],
			[0.0, (v2eff(-0.0043404,40,512)-v2eff(-0.0043404 - 0.0000086, 40, 512))]

# ╔═╡ bd82bf9a-0820-4d25-a860-f27255958851
linear(x) = VirialUEG.v2(temp) - x*VirialUEG.v3(temp)

# ╔═╡ 704bc482-98dd-46a5-8c07-e03826ef73ca
p = @pgf Axis({
		xlabel = L"-\sqrt{n_B}\ln(4\pi n_B/T_{\rm{Ha}}^2)",
		ylabel = L"v_2^{\rm{eff}}(T,n)",
		height = "7cm",
		width = "9.5cm",
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
			[-xx(n(20),temp), -xx(n(40),temp), -xx(n(12.5),temp)], 
			[v2eff(-0.011929,20,128),v2eff(-0.0043404, 40, 512), v2eff(-0.0233818166902136, 12.5, 50)],
			yerror = [0.0, (v2eff(-0.0043404,40,512)-v2eff(-0.0043404 - 0.0000086, 40, 512)), (v2eff(-0.0233818166902136, 12.5, 50)-v2eff(-0.0233818166902136 - 9.15997040568106e-06, 12.5, 50))]
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
	[raw"\node ", " at ", Coordinate(0.06,-5),"{\$T_{\\rm Ha}\$=$(round(temp,digits=3))};"]
)

# ╔═╡ e9728c3e-51ea-4f43-b7c5-43d6ff8c89a2
pgfsave("fig_casus_20_128.pdf",p)

# ╔═╡ 768ab2ce-7fa2-4c11-9f4f-a0487ffe2a13
[linear(0.0), linear(0.07)]

# ╔═╡ a8872867-2aec-45a0-b5bb-31261c7a7529
linear2(x) = VirialUEG.v2(temp2) - x*VirialUEG.v3(temp2)

# ╔═╡ 9f982a36-8952-489a-8395-f5c8544d970c
v2eff(-0.0306025317180878, 12.5, 25)

# ╔═╡ 3ddf49bf-92dc-45d7-8dab-49c98bc2cdc4
p2 = @pgf Axis(
	{
		xlabel = L"-\sqrt{n_B}\ln(4\pi n_B/T_{\rm{Ha}}^2)",
		ylabel = L"v_2^{\rm{eff}}(T,n)",
		height = "7cm",
		width = "9.5cm",
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
		[-xx(n(20),temp2), -xx(n(40),temp2), -xx(n(12.5),temp2)], 
		[v2eff(-0.016005,20,64),v2eff(-0.00597188, 40, 256), v2eff(-0.0306025317180878, 12.5, 25)],
		yerror = [0.0, (v2eff(-0.00597188,40,256)-v2eff(-0.00597188 - 0.00001116, 40, 256)), (v2eff(-0.0306025317180878, 12.5, 25) - v2eff(-0.0306025317180878 - 9.12984083721591e-06, 12.5, 25))]
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
[raw"\node ", " at ", Coordinate(0.03,-25),"{\$T_{\\rm Ha}\$=$(round(temp2,digits=3))};"]
)

# ╔═╡ 75f14c80-4f13-44c1-9ba8-9b4e35e4fa92
		[0.0, 0.05],
		[linear2(0.0), linear2(0.05)]

# ╔═╡ 27741f0e-a935-4f08-bb59-1f0b552c105d
pgfsave("fig_casus_20_64.pdf",p2)

# ╔═╡ 6fdf6faa-3706-4549-8e63-a288cd922cbe
md"## Figure 3"

# ╔═╡ e3acbc5a-31cc-4030-844f-093b6cb60566
linear3(x) = VirialUEG.v2(temp3) - x*VirialUEG.v3(temp3)

# ╔═╡ 141f22dd-afb2-44bb-b585-37e8ae8248cd
length(x3axis)/7 *2

# ╔═╡ f4aeb3a9-7337-4553-b7c7-ca84b262cf76
fitlinear(-x3axis[3400:end], y3axis[3400:end])

# ╔═╡ 1bd5559f-4b4c-4afa-8d5f-67d8e72f2c26
v2eff(-0.0889925255176875, 1, 54.3)

# ╔═╡ c66cd189-60a1-4743-bf74-0bfbebb9b66a
-xx(n(0.5),temp3)

# ╔═╡ 47b6f1b7-d45a-4b45-bf9d-bb691a26bb9a
p3 = @pgf Axis(
	{
		xlabel = L"-\sqrt{n_B}\ln(4\pi n_B/T_{\rm{Ha}}^2)",
		ylabel = L"v_2^{\rm{eff}}(T,n)",
		height = "7cm",
		width = "9.5cm",
		scaled_ticks = false,
		tick_label_style = "/pgf/number format/fixed, /pgf/number format/precision=5",
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
		[-xx(n(2),temp3), -xx(n(1),temp3)], 
		[v2eff(-0.030854464445,2,217.204), v2eff(-0.0889925255176875, 1, 54.3)],
		yerror = [(v2eff(-0.030854464445,2,217.204)-v2eff(-0.030854464445 - 0.00006612,2,217.204)), (v2eff(-0.0889925255176875, 1, 54.3) - v2eff(-0.0889925255176875 - 0.000275393209366551, 1, 54.3))]
	)
),
LegendEntry("PIMC"),
PlotInc(
	{
	dashed,
	no_marks
	},
	Coordinates(
		[0.0, 5.0],
		[linear3(0.0), linear3(5.0)]
	)
),
LegendEntry("virial 2+3"),
PlotInc(
	{
	dashdotted,
	black,
	no_marks
	},
Expression("0.0002893002586723349*x - 0.012825684192487695")
	# Coordinates(
	# 	[0.0, 1.0],
	# 	[-0.012825684192487695, 0.0002893002586723349 - 0.012825684192487695]
	# )
),
LegendEntry("linear extrapol."),
PlotInc({
	mark = "*",
black,
mark_options = {fill = "black"}

},
	Coordinates(
		[0.0], [-0.012825684192487695]
	)
),
PlotInc({
	mark = "*",
black,
mark_options = {fill = "black"}

},
	Coordinates(
		[0.0], [linear3(0.0)]
	)
),
[raw"\node ", " at ", Coordinate(3.5,-0.008),"{\$T_{\\rm Ha}\$ = 100};"]
)

# ╔═╡ 204cbf81-17fe-440d-8dcf-21d10ef55300
		[0.0, 3.0],
		[linear3(0.0), linear3(3.0)]

# ╔═╡ 05301310-c6df-4836-bf15-dd9772afd8d1
pgfsave("fig_casus_100.pdf",p3)

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

# ╔═╡ 934e6da6-b909-4998-b9b0-3ab7d8f46ca1
v4_eff(virial_interp, 2, 217.204)

# ╔═╡ 43e909df-7a75-45d9-85a2-241a7e312eee
n(0.01)

# ╔═╡ c38dfbe9-676b-4fc8-a909-93fc3f72cc0a
v4_eff(virial_interp, 0.2,theta(0.2,100))

# ╔═╡ b9c4f178-5a44-404a-a67f-fd0f0647e90c
linear4(1.0)

# ╔═╡ d354adca-ff36-4986-8073-ae5c1cd26477
- 1.0/log(4π*n(0.25)/temp4^2)

# ╔═╡ 5b9d1f5a-501f-42a0-97fa-11fd87eb28cf
p4 = @pgf Axis(
	{
		xlabel = L"-1/\ln(4\pi n_{\rm B}/T_{\rm{Ha}}^2)",
		ylabel = L"v_3^{\rm{eff}}(T,n)",
		height = "7cm",
		width = "9.5cm",
		scaled_ticks = false,
		tick_label_style = "/pgf/number format/fixed, /pgf/number format/precision=5",
		xmin=0.0,
xmax=0.3,
		legend_pos = "south east"
	},
	PlotInc({
		no_marks
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
		[- 1.0/log(4π*n(2)/temp4^2), - 1.0/log(4π*n(1)/temp4^2)], 
		[v3_eff((r,θ)->-0.030854464445,2,217.204), v3_eff((r,θ)-> -0.0889925255176875,1,54.3)],
		yerror = [(v3_eff((r,θ)->-0.030854464445,2,217.204) - v3_eff((r,θ)->-0.030854464445 -0.00006612,2,217.204)), (v3_eff((r,θ)-> -0.0889925255176875,1,54.3) - v3_eff((r,θ)-> -0.0889925255176875 - 0.000275393209366551,1,54.3))]
	)
),
LegendEntry("PIMC"),
PlotInc(
	{
	dashed,
	black,
	no_marks
	},
	Coordinates(
		[0.0, 1.0],
		[linear4(0.0), linear4(1.0)]
	)
),
LegendEntry("virial 3+4 (fitted)"),
PlotInc(
	{
	dashdotted,
	black,
	no_marks
	},
	Coordinates(
		[0.0, 1.0],
		[VirialUEG.v3(temp4), VirialUEG.v3(temp4) - 0.001295]
	)
),
LegendEntry("virial 3+4 (exact)"),
[raw"\node ", " at ", Coordinate(0.2,0.001),"{\$T_{\\rm{Ha}}\$ = 100};"],
PlotInc({
	mark = "*",
black,
mark_options = {fill = "black"}

},
	Coordinates(
		[0.0], [linear4(0.0)]
	)
)
)

# ╔═╡ 7470cbfd-a0dd-4f2d-a103-fbb4eeab30ca
		[0.0, 1.0],
		[linear4(0.0), linear4(1.0)]

# ╔═╡ b02a9057-332e-458b-8479-dd7f9a23f67e
		[0.0, 1.0],
		[VirialUEG.v3(temp4), VirialUEG.v3(temp4) - 0.001295]

# ╔═╡ 89cbd087-3363-4029-8cac-11ee7c6f8ba0
pgfsave("v3_eff3.pdf",p4)

# ╔═╡ b21f675f-d286-4d11-9d39-8a8595c2ad33
begin
	writedlm("casus_20_128.dat",hcat(-xaxis,yaxis),'\t')
	writedlm("casus_20_64.dat",hcat(-x2axis,y2axis),'\t')
	writedlm("casus_100.dat",hcat(-x3axis,y3axis),'\t')
	writedlm("v3_eff.dat",hcat(-x4axis,y4axis),'\t')
end

# ╔═╡ 145465c5-57ce-4688-b0a9-7d0a03cf6eec
rlist = [10, 4, 2, 1.6, 1, 0.8, 0.5]

# ╔═╡ 12d57eeb-5e36-4efd-82be-361488199d2e
thetalist = theta.(rlist, 100)

# ╔═╡ 1ce14d27-0961-4cb9-8f3e-8bf32071ea08
[-1/log(4π*n(r)/100^2) for r in rlist]

# ╔═╡ 58e84d2f-ee88-4c55-afae-983f67a32699
v2list = [v3_eff(virial_interp, r, θ) for (r, θ) in zip(rlist, thetalist)]

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
# ╠═4d870e03-a69c-4162-8088-545eb9199594
# ╠═0d859187-d70a-40a9-b959-fd8ae448abd7
# ╠═704bc482-98dd-46a5-8c07-e03826ef73ca
# ╠═87b66793-079e-4a2c-9c69-774a622a9abe
# ╠═768ab2ce-7fa2-4c11-9f4f-a0487ffe2a13
# ╠═e9728c3e-51ea-4f43-b7c5-43d6ff8c89a2
# ╠═bd82bf9a-0820-4d25-a860-f27255958851
# ╠═a8872867-2aec-45a0-b5bb-31261c7a7529
# ╠═9f982a36-8952-489a-8395-f5c8544d970c
# ╠═3ddf49bf-92dc-45d7-8dab-49c98bc2cdc4
# ╠═75f14c80-4f13-44c1-9ba8-9b4e35e4fa92
# ╠═27741f0e-a935-4f08-bb59-1f0b552c105d
# ╟─6fdf6faa-3706-4549-8e63-a288cd922cbe
# ╠═e3acbc5a-31cc-4030-844f-093b6cb60566
# ╠═f3833fa6-6e92-4656-9af0-35a838143e52
# ╠═141f22dd-afb2-44bb-b585-37e8ae8248cd
# ╠═f4aeb3a9-7337-4553-b7c7-ca84b262cf76
# ╠═1bd5559f-4b4c-4afa-8d5f-67d8e72f2c26
# ╠═c66cd189-60a1-4743-bf74-0bfbebb9b66a
# ╠═47b6f1b7-d45a-4b45-bf9d-bb691a26bb9a
# ╠═204cbf81-17fe-440d-8dcf-21d10ef55300
# ╠═05301310-c6df-4836-bf15-dd9772afd8d1
# ╠═0c6ef315-bd2f-433f-8a0f-4d259528b641
# ╠═e526856c-c211-400f-ae7e-10b3293cead2
# ╠═5f7d2903-2f83-4d0e-82c1-5b911a58ebd9
# ╠═934e6da6-b909-4998-b9b0-3ab7d8f46ca1
# ╠═43e909df-7a75-45d9-85a2-241a7e312eee
# ╠═c38dfbe9-676b-4fc8-a909-93fc3f72cc0a
# ╠═b9c4f178-5a44-404a-a67f-fd0f0647e90c
# ╠═d354adca-ff36-4986-8073-ae5c1cd26477
# ╠═5b9d1f5a-501f-42a0-97fa-11fd87eb28cf
# ╠═7470cbfd-a0dd-4f2d-a103-fbb4eeab30ca
# ╠═b02a9057-332e-458b-8479-dd7f9a23f67e
# ╠═89cbd087-3363-4029-8cac-11ee7c6f8ba0
# ╠═b21f675f-d286-4d11-9d39-8a8595c2ad33
# ╠═145465c5-57ce-4688-b0a9-7d0a03cf6eec
# ╠═12d57eeb-5e36-4efd-82be-361488199d2e
# ╠═1ce14d27-0961-4cb9-8f3e-8bf32071ea08
# ╠═58e84d2f-ee88-4c55-afae-983f67a32699
