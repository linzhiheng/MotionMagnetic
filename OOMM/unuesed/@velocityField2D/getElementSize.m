function getElementSize(obj, inputs)
            switch (numel(inputs))
            case {2 3}  %manul
                obj.elementSize.dx = inputs{1};
                obj.elementSize.dz = inputs{2};
            case {0 1}  %default
                obj.elementSize.dx = 1;
                obj.elementSize.dz = 1;
            end
end