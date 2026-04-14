// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title CulturaChad
 * @dev Registro de superalimentos biotecnologicos y preservacion lacustre.
 * Serie: Sabores de Africa (22/54)
 */
contract CulturaChad {

    struct Plato {
        string nombre;
        string ingredientes;
        string preparacion;
        uint256 purezaDihe;        // Porcentaje de concentracion de Espirulina (1-100)
        uint256 firmezaSalanga;    // Grado de deshidratacion del pescado (1-10)
        bool requiereAhumado;      // Tecnica de preservacion adicional
        uint256 likes;
        uint256 dislikes;
    }

    mapping(uint256 => Plato) public registroCulinario;
    uint256 public totalRegistros;
    address public owner;

    constructor() {
        owner = msg.sender;
        // Inauguramos con la Salsa de Dihe (Superalimento ancestral)
        registrarPlato(
            "Salsa de Dihe", 
            "Espirulina (Dihe), tomates, cebollas, pimientos, aceite de palma.",
            "Rehidratar las galletas de espirulina y cocinar en una base de estofado rico en vegetales.",
            95, 
            0, 
            false
        );
    }

    function registrarPlato(
        string memory _nombre, 
        string memory _ingredientes,
        string memory _preparacion,
        uint256 _pureza, 
        uint256 _firmeza,
        bool _ahumado
    ) public {
        require(bytes(_nombre).length > 0, "Nombre requerido");
        require(_pureza <= 100, "Pureza no puede exceder el 100%");

        totalRegistros++;
        registroCulinario[totalRegistros] = Plato({
            nombre: _nombre,
            ingredientes: _ingredientes,
            preparacion: _preparacion,
            purezaDihe: _pureza,
            firmezaSalanga: _firmeza,
            requiereAhumado: _ahumado,
            likes: 0,
            dislikes: 0
        });
    }

    function darLike(uint256 _id) public {
        require(_id > 0 && _id <= totalRegistros, "ID invalido");
        registroCulinario[_id].likes++;
    }

    function darDislike(uint256 _id) public {
        require(_id > 0 && _id <= totalRegistros, "ID invalido");
        registroCulinario[_id].dislikes++;
    }

    function consultarPlato(uint256 _id) public view returns (
        string memory nombre,
        uint256 pureza,
        uint256 firmeza,
        bool ahumado,
        uint256 likes,
        uint256 dislikes
    ) {
        require(_id > 0 && _id <= totalRegistros, "ID inexistente");
        Plato storage p = registroCulinario[_id];
        return (p.nombre, p.purezaDihe, p.firmezaSalanga, p.requiereAhumado, p.likes, p.dislikes);
    }
}
