mutable struct Ship
    pos
    direction
end

L = v -> [cos(deg2rad(v)) -sin(deg2rad(v)); sin(deg2rad(v)) cos(deg2rad(v))]
R = v -> [cos(deg2rad(v)) sin(deg2rad(v)); -sin(deg2rad(v)) cos(deg2rad(v))]

op = Dict(
    'F' => (x, v) -> x.pos += v * x.direction,
    'L' => (x, v) -> x.direction = L(v) * x.direction,
    'R' => (x, v) -> x.direction = R(v) * x.direction,
    'N' => (x, v) -> x.pos += [0; 1] * v,
    'E' => (x, v) -> x.pos += [1; 0] * v,
    'S' => (x, v) -> x.pos += [0; -1] * v,
    'W' => (x, v) -> x.pos += [-1; 0] * v
)

ship = Ship([0;0], [1;0])

lines = readlines("input.txt")

for line in lines
    op[line[1]](ship, parse(Float32, line[2:end]))
end
println(ship)
println(sum(abs.(ship.pos)))



