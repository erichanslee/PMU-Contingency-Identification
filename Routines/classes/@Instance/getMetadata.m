% unpacks metadata for use
function [numcontigs, numbuses, filename, timestep, numlines, differential, algebraic] = getMetadata(obj)

try
    numcontigs = obj.metadata.numcontigs;
    numbuses = obj.metadata.numbuses;
    filename = obj.metadata.filename;
    timestep = obj.metadata.timestep;
    numlines = obj.metadata.numlines;
    differential = obj.metadata.differential;
    algebraic = obj.metadata.algebraic;
catch
    error('Metadata Not Initalized Properly');
end

end

