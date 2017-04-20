function getElementSize(obj, inputs)
            switch (numel(inputs))
            case {3 4}  %manul
                obj.elementSize.dx = inputs{1};
                obj.elementSize.dy = inputs{2};
                obj.elementSize.dz = inputs{3};
            case {0 1}  %default
                obj.elementSize.dx = 1;
                obj.elementSize.dy = 1;
                obj.elementSize.dz = 1;
            end
end