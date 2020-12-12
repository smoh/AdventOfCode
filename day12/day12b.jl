mutable struct Ship
    pos
    poswp    # waypoint is always relative to ship
end

L = v -> [cos(deg2rad(v)) -sin(deg2rad(v)); sin(deg2rad(v)) cos(deg2rad(v))]
R = v -> [cos(deg2rad(v)) sin(deg2rad(v)); -sin(deg2rad(v)) cos(deg2rad(v))]

op = Dict(
    'F' => (x, v) -> x.pos += v * x.poswp,
    'L' => (x, v) -> x.poswp = L(v) * x.poswp,
    'R' => (x, v) -> x.poswp = R(v) * x.poswp,
    'N' => (x, v) -> x.poswp += [0; 1] * v,
    'E' => (x, v) -> x.poswp += [1; 0] * v,
    'S' => (x, v) -> x.poswp += [0; -1] * v,
    'W' => (x, v) -> x.poswp += [-1; 0] * v
)

ship = Ship([0;0], [10; 1])
lines = readlines("input.txt")
for line in lines
    op[line[1]](ship, parse(Float32, line[2:end]))
end
println(ship)
println(sum(abs.(ship.pos)))



