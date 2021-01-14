# Skipping MacroDefinition: IMPEXP __declspec ( dllimport )
const ngcomplex_t = Complex{Cdouble}

const VF_REAL = (1 << 0)
const VF_COMPLEX = (1 << 1)
const VF_ACCUM = (1 << 2)
const VF_PLOT = (1 << 3)
const VF_PRINT = (1 << 4)
const VF_MINGIVEN = (1 << 5)
const VF_MAXGIVEN = (1 << 6)
const VF_PERMANENT = (1 << 7)

struct vector_info
    name::Cstring
    type::Cint
    flags::Int16
    realdata::Ptr{Cdouble}
    compdata::Ptr{ngcomplex_t}
    length::Cint
end

const pvector_info = Ptr{vector_info}

struct vecvalues
    name::Cstring
    creal::Cdouble
    cimag::Cdouble
    is_scale::Cint
    is_complex::Cint
end

const pvecvalues = Ptr{vecvalues}

struct vecvaluesall
    veccount::Cint
    vecindex::Cint
    vecsa::Ptr{pvecvalues}
end

const pvecvaluesall = Ptr{vecvaluesall}

struct vecinfo
    number::Cint
    vecname::Cstring
    is_real::Cint
    pdvec::Ptr{Cvoid}
    pdvecscale::Ptr{Cvoid}
end

const pvecinfo = Ptr{vecinfo}

struct vecinfoall
    name::Cstring
    title::Cstring
    date::Cstring
    type::Cstring
    veccount::Cint
    vecs::Ptr{pvecinfo}
end

const pvecinfoall = Ptr{vecinfoall}

#=Function pointers skipped by the generator

SendChar       typedef of callback function for reading printf, fprintf, fputs
SendStat       typedef of callback function for reading status string and precent value
ControlledExit typedef of callback function for tranferring a signal upon
               ngspice controlled_exit to caller. May be used by caller
               to detach ngspice.dll.
SendData       typedef of callback function for sending an array of structs containing
               data values of all vectors in the current plot (simulation output)
SendInitData   typedef of callback function for sending an array of structs containing info on
               all vectors in the current plot (immediately before simulation starts)
BGThreadRunning typedef of callback function for sending a boolean signal (true if thread
                is running)
=#

const FnTypeSignatures = Dict(
    :SendChar        => (:Cint, :((Ptr{Char}, Cint, Ptr{Cvoid}))),
    :SendStat        => (:Cint, :((Ptr{Char}, Cint, Ptr{Cvoid}))),
    :ControlledExit  => (:Cint, :((Cint, Cint, Cint, Cint, Ptr{Cvoid}))),
    :SendData        => (:Cint, :((Ptr{vecvaluesall}, Cint, Cint, Ptr{Cvoid}))),
    :SendInitData    => (:Cint, :((Ptr{vecinfoall}, Cint, Ptr{Cvoid}))),
    :BGThreadRunning => (:Cint, :((Cint, Cint, Ptr{Cvoid}))),
    :GetVSRCData     => (:Cint, :((Ptr{Cdouble}, Cdouble, Ptr{Cchar}, Cint, Ptr{Cvoid}))),
    :GetISRCData     => (:Cint, :((Ptr{Cdouble}, Cdouble, Ptr{Cchar}, Cint, Ptr{Cvoid}))),
    :GetSyncData     => (:Cint, :((Cdouble, Ptr{Cdouble}, Cdouble, Cint, Cint, Cint, Ptr{Cvoid})))
)

SendChar_wrapper(fp::Ptr{Cvoid}) = fp
SendChar_wrapper(f) = @cfunction($f, Cint, (Ptr{Char}, Cint, Ptr{Cvoid})).ptr

SendStat_wrapper(fp::Ptr{Cvoid}) = fp
SendStat_wrapper(f) = @cfunction($f, Cint, (Ptr{Char}, Cint, Ptr{Cvoid})).ptr

ContolledExit_wrapper(fp::Ptr{Cvoid}) = fp
ContolledExit_wrapper(f) = @cfunction($f, Cint, (Cint, Cint, Cint, Cint, Ptr{Cvoid})).ptr

SendData_wrapper(fp::Ptr{Cvoid}) = fp
SendData_wrapper(f) = @cfunction($f, Cint, (Ptr{vecvaluesall}, Cint, Cint, Ptr{Cvoid})).ptr

SendInitData_wrapper(fp::Ptr{Cvoid}) = fp
SendInitData_wrapper(f) = @cfunction($f, Cint, (Ptr{vecinfoall}, Cint, Ptr{Cvoid})).ptr

BGThreadRunning_wrapper(fp::Ptr{Cvoid}) = fp
BGThreadRunning_wrapper(f) = @cfunction($f, Cint, (Cint, Cint, Ptr{Cvoid})).ptr

GetVSRCData_wrapper(fp::Ptr{Cvoid}) = fp
GetVSRCData_wrapper(f) = @cfunction($f, Cint, (Ptr{Cdouble}, Cdouble, Ptr{Cchar}, Cint, Ptr{Cvoid})).ptr


GetISRCData_wrapper(fp::Ptr{Cvoid}) = fp
GetISRCData_wrapper(f) = @cfunction($f, Cint, (Ptr{Cdouble}, Cdouble, Ptr{Cchar}, Cint, Ptr{Cvoid})).ptr


GetSyncData_wrapper(fp::Ptr{Cvoid}) = fp
GetSyncData_wrapper(f) = @cfunction($f, Cint, (Cdouble, Ptr{Cdouble}, Cdouble, Cint, Cint, Cint, Ptr{Cvoid})).ptr

function SendChar(text::String, id::Int32, userdata)
    println("SPICE : $text" )
end

sendchar = @cfunction($SendChar, Cint, (Cstring, Cint, Ptr{Cvoid}))

function SendStat(text::String, id::Int32, userdata)

    println("SPICE : $text" )
    return 0
end

sendstat = @cfunction($SendStat, Cint, (Cstring, Cint, Ptr{Cvoid}))

function SendInitData(pvia::Ptr{vecinfoall}, id, ptr)

    println(pvia)
    return 0
end
sendinitdata = @cfunction($SendInitData, Cint, (Ptr{vecinfoall}, Cint, Ptr{Cvoid}))
