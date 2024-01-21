const fs = require('node:fs')


function lerArquivo(path) {
    try {
        return fs.readFileSync(path, 'utf8')
    } catch (error) {
        console.error(error)
    }
}

function escreverArquivo(path, data) {
    try {
        return fs.writeFileSync(path, data)
    } catch (error) {
        console.error(error)
    }
}

function substituirCaracteres(dados, campo) {
    return dados.map((item) =>  {
        item[campo] = item[campo].replaceAll('æ','a').replaceAll('ø', 'o')
        return item
    })
}

function corrigirValorVendas(dados) {
    return dados.map((venda) => {
        venda.vendas = parseInt(venda.vendas)
        return venda
    })
}


function executa() {
    // Lendo os arquivos
    const arquivoVeiculos = JSON.parse(lerArquivo('docs/broken_database_1.json'))
    const arquivoMarcas = JSON.parse(lerArquivo('docs/broken_database_2.json'))

    // Tratando os caracteres incorretos
    let arquivoVeiculosCorrigido = substituirCaracteres(arquivoVeiculos, 'nome')
    let arquivoMarcasCorrigido = substituirCaracteres(arquivoMarcas, 'marca')
    arquivoVeiculosCorrigido = corrigirValorVendas(arquivoVeiculosCorrigido)

    // Escrevendo arquivos com os dados corrigidos.
    escreverArquivo('docs/arquivo_veiculos.json', JSON.stringify(arquivoVeiculosCorrigido))
    escreverArquivo('docs/arquivo_marcas.json', JSON.stringify(arquivoMarcasCorrigido))
}


executa();




